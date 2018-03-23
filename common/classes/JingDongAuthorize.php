<?php
namespace common\classes;
use Yii;
/**
 * 京东获取token相关API接口  接口调用说明结合京东api
 * Created by PhpStorm.
 * User: pzh
 * Date: 2017/10/9
 * Time: 13:44
 */
class JingDongAuthorize extends JingDongBase {

    protected static $_instance = null;

    protected function __construct() {
        //disallow new instance
        parent::__construct();
    }

    protected function __clone() {
        //disallow clone
    }

    public static function getInstance() {
        if(self::$_instance === null) {
            self::$_instance = new self();
        }
        return self::$_instance;
    }

    /**
     * 获取access_token
     * @return string
     * @throws Exception
     */
    public function getToken() {
        $accessToken = "";
        $authorizeInfo = Yii::$app->wnmall->createCommand('select * from wn_jingdong_authorize where app_key = :app_key',array(":app_key" => $this->appKey))->queryOne();
        if(!$authorizeInfo) { // 数据库中无授权信息
            $accessToken = $this->getAccessToken();
        } else if(empty($authorizeInfo['access_token']) || empty($authorizeInfo['refresh_token']) || $authorizeInfo['refresh_expire_time'] < time()) { // refresh_token过期 ,refresh_token不存在,重新获取token
            $accessToken = $this->getAccessToken(true);
        } else if(($authorizeInfo['token_expire_time'] - time()) <= 172800) { // 授权过期，刷新token，提前两天刷新
            $accessToken = $this->refreshAccessToken();
        } else if(($authorizeInfo['token_expire_time'] - time()) > 172800) {
            $accessToken = $authorizeInfo['access_token'];
        }

        if(empty($accessToken)) {
            //记录手动抛出的异常日志
            $this->recordLogs("JingDongAuthorize.getToken", "", "empty accessToken", "exception");
            throw new Exception("get token failed,empty token!");
        }

        return $accessToken;
    }

    /**
     * 获取token接口,token有效期30天，获取token接口调用次数限制30次/月,refresh_token 有效期一年
     * @param       bool        $isExistToken 区分插入还是更新
     * @return mixed|string
     * @throws Exception
     */
    public function getAccessToken($isExistToken = false) {
        $accessToken = "";
        $getTokenUrl = "https://kploauth.jd.com/oauth/token?grant_type=password&app_key=" . $this->appKey . "&app_secret=" . $this->appSecret
            . "&state=getToken&username=" . $this->username . "&password=" . $this->password;

        $authorizeInfoJson = $this->myCurlGet($getTokenUrl);
        $authorizeInfoArray = json_decode($authorizeInfoJson, true);

        if(empty($authorizeInfoArray)) {
            //记录手动抛出的异常日志
            $this->recordLogs("JingDongAuthorize.getAccessToken", $authorizeInfoJson, "empty response", "exception");
            throw new Exception("authorize failed,empty response!");
        }

        if(isset($authorizeInfoArray['code']) && $authorizeInfoArray['code'] != 0) {
            // 记录手动抛出的异常日志
            $this->recordLogs("JingDongAuthorize.getAccessToken", $authorizeInfoJson, "The result of the response is incorrect", "exception");
            throw new Exception("authorize failed,The result of the response is incorrect!");
        }

        //记录日志
        $this->recordLogs("JingDongAuthorize.getAccessToken", $authorizeInfoJson);
        $getTokenTime = strtotime(date("Y-m-d H:i:s"), $authorizeInfoArray['time']);
        $accessToken = $authorizeInfoArray['access_token'];
        $expiresIn = $authorizeInfoArray['expires_in'];
        $tokenExpireTime = $getTokenTime + $authorizeInfoArray['expires_in'];// access_token授权到期时间,有效期一个月,为了安全，提前两天刷新
        $refreshToken = $authorizeInfoArray['refresh_token'];
        $refreshTokenExpireTime = $getTokenTime + 60*60*24*350;// refresh_token授权到期时间,有效期一年,为了安全，提前十五天刷新
        $tokenType = $authorizeInfoArray['token_type'];// 授权类型
        $uid = $authorizeInfoArray['uid'];
        $userNick = $authorizeInfoArray['user_nick'];

        $insertCondtions = array(
            'app_key' => $this->appKey,
            'access_token' => $accessToken,
            'expires_in' => $expiresIn,
            'token_expire_time' => $tokenExpireTime,
            'refresh_token' => $refreshToken,
            'refresh_expire_time' => $refreshTokenExpireTime,
            'token_type' => $tokenType,
            'uid' => $uid,
            'user_nick' => $userNick,
            'add_time' => date("Y-m-d H:i:s",time()),
        );

        if(!$isExistToken) {
            $this->insertAuthorezeInfo($insertCondtions);
        } else {
            $updateCondtions = array(
                'access_token' => $accessToken,
                'expires_in' => $expiresIn,
                'token_expire_time' => $tokenExpireTime,
                'refresh_token' => $refreshToken,
                'refresh_expire_time' => $refreshTokenExpireTime,
                'token_type' => $tokenType,
                'uid' => $uid,
                'user_nick' => $userNick,
                'update_time' => date("Y-m-d H:i:s",time()),
            );

            $where = "app_key = :app_key";
            $params = array(":app_key" => $this->appKey);

            $this->updateAuthorezeInfo($updateCondtions, $where, $params);
        }

        return $accessToken;
    }

    /**
     * 刷新token接口,token有效期30天
     */
    public function refreshAccessToken() {
        $accessToken = "";
        $refreshTokenUrl = "https://kploauth.jd.com/oauth/token?grant_type=refresh_token&app_key=" . $this->appKey . "&app_secret=" . $this->appSecret
            . "&state=refreshToken&username=" . $this->username . "&password=" . $this->password;

        $authorizeInfoJson = $this->myCurlGet($refreshTokenUrl);
        $authorizeInfoArray = json_decode($authorizeInfoJson, true);

        if(empty($authorizeInfoArray)) {
            //记录手动抛出的异常日志
            $this->recordLogs("JingDongAuthorize.refreshAccessToken", $authorizeInfoJson, "empty response", "exception");
            throw new Exception("authorize fail,empty response");
        }

        if(isset($authorizeInfoArray['code']) && $authorizeInfoArray['code'] != 0) {
            // 记录手动抛出的异常日志
            $this->recordLogs("JingDongAuthorize.getAccessToken", $authorizeInfoJson, "The result of the response is incorrect", "exception");
            throw new Exception("authorize failed,The result of the response is incorrect!");
        }

        //记录日志
        $this->recordLogs("JingDongAuthorize.refreshAccessToken", $authorizeInfoJson);
        $getTokenTime = strtotime(date("Y-m-d H:i:s"), $authorizeInfoArray['time']);
        $accessToken = $authorizeInfoArray['access_token'];
        $tokenExpireTime = $getTokenTime + $authorizeInfoArray['expires_in'];// access_token授权到期时间,有效期一个月,为了安全，提前两天刷新

        $condtions = array(
            'access_token' => $accessToken,
            'expires_in' => $authorizeInfoArray['expires_in'],
            'token_expire_time' => $tokenExpireTime,
            'update_time' => date("Y-m-d H:i:s",time()),
        );

        $where = "app_key = :app_key";
        $params = array(":app_key" => $this->appKey);

        $this->updateAuthorezeInfo($condtions, $where, $params);

        return $accessToken;
    }

    /**
     * 授权信息入库
     * @param $condtions
     * @return mixed
     */
    public function insertAuthorezeInfo($condtions) {
        Yii::app()->db->createCommand()->insert("{{jingdong_authorize}}", $condtions);
        return Yii::app()->db->getLastInsertID();
    }

    /**
     * 授权信息更新
     * @param $condtions
     * @param $where
     * @param $params
     * @return mixed
     */
    public function updateAuthorezeInfo($condtions, $where, $params) {
        return Yii::app()->db->createCommand()->update("{{jingdong_authorize}}", $condtions, $where, $params);
    }
}