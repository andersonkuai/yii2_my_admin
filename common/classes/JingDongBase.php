<?php
namespace common\classes;

use common\helpers\Func;
use Yii;
/**
 * 通用基础功能
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/10/17
 * Time: 16:49
 */
class JingDongBase {

    protected $appKey;
    protected $appSecret;
    protected $username;// 中文用户名需要urlencode
    protected $password;// 32位的MD5加密（小写）
    protected $apiUrl = "https://router.jd.com/api";
    protected $basePathUrl = "https://img13.360buyimg.com";

    protected static $_instance = null;

    protected function __construct() {
        //disallow new instance
        $this->appKey = Func::param('jingDongConfig', 'appKey');
        $this->appSecret = Func::param('jingDongConfig', 'appSecret');
        $this->username = urlencode(Func::param('jingDongConfig', 'username'));
        $this->password = strtolower(md5(Func::param('jingDongConfig', 'password')));
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
     * 拼装GET API请求
     * @param   $method        API接口名称
     * @param   $param_json    业务参数
     * @param   $url           请求地址
     * @return string
     */
    public function createGetRequest($method, $businessParams, $url) {
        $jingDongAuthorize = JingDongAuthorize::getInstance();
        $accessToken = $jingDongAuthorize->getToken();
        $time = date("Y-m-d H:m:s", time());
        $businessParams = json_encode($businessParams);
        $params = array(
            'method' => $method,
            'app_key' => $this->appKey,
            'access_token' => $accessToken,
            'timestamp' => $time,
            'v' => "1.0",
            'format' => "json",
            'param_json' => $businessParams,
        );

        $requestUrl = $url . "?" . http_build_query( $params );
        return $requestUrl;
    }

    /**
     * 拼装POST API请求
     * @param           $method             API接口名称
     * @param string    $businessParams     业务参数，如果没有入参值为{}
     * @return string
     */
    public function createPostRequest($method, $businessParams, $url) {
        $jingDongAuthorize = JingDongAuthorize::getInstance();
        $accessToken = $jingDongAuthorize->getToken();
        $time = date("Y-m-d H:m:s", time());

        $systemParams = array(
            'method' => $method,
            'app_key' => $this->appKey,
            'access_token' => $accessToken,
            'timestamp' => $time,
            'v' => "1.0",
            'format' => "json",
        );

        $businessParams = array(
            "param_json" =>  trim(json_encode($businessParams),'"'),
        );

        $requestUrl = $url . "?" . http_build_query( $systemParams );

        $result = array(
            'url' => $requestUrl,
            "data" => $businessParams
        );

        return $result;
    }

    /**
     * 拼接业务参数
     * @param $paramKeys 业务参数可传键
     * @param $requestData 业务参数实传值
     * @return array
     */
    public function createBusinessParameter($paramKeys, $requestData) {
        $paramArray = array();

        //拼接业务参数
        foreach($requestData AS $key=>$value) {
            if(in_array($key, $paramKeys)) {
                $paramArray[$key] = $requestData[$key];
            }
        }

        return $paramArray;
    }

    /**
     * 拼接图片地址
     * n0(最大图)、n1(350*350px)、n2(160*160px)、n3(130*130px)、n4(100*100px)
     * @param $imageUrl
     */
    public function createImagepathUrl($imageUrl) {

        $imageUrlArray = array(
            'n0' => $this->basePathUrl . "/n0/" . $imageUrl,
            'n1' => $this->basePathUrl . "/n1/" . $imageUrl,
            'n2' => $this->basePathUrl . "/n2/" . $imageUrl,
            'n3' => $this->basePathUrl . "/n3/" . $imageUrl,
            'n4' => $this->basePathUrl . "/n4/" . $imageUrl,
        );

        return $imageUrlArray;
    }

    /**
     * 请求API接口
     * @param $method 请求的方法
     * @param $businessParams 业务参数
     * @return mixed
     */
    public function requestApi($method, $businessParams = array(), $url = "", $type = "post") {
        if(empty($businessParams)) {
            $businessParams = "{}";
        }

        if(empty($url)) {
            $url = $this->apiUrl;
        }

        $resultArray = array();

        if($type === "get") {
            $requestUrl = $this->createGetRequest($method, $businessParams, $url);
            $resultArray = $this->getResponse($method, $requestUrl);
        } else if($type === "post") {
            $postArray = $this->createPostRequest($method, $businessParams, $url);
            $resultArray = $this->getResponse($method, $postArray['url'], "post", $postArray['data']);
        }

        if(!empty($resultArray)) {
            foreach($resultArray as $key=>$value) {
                return $value;
            }
        }

        return $resultArray;
    }

    /**
     * 获取接口响应信息
     * @param $method  API名称
     * @param $url
     * @param Array $data
     * @return mixed
     * @throws Exception
     */
    public function getResponse($method, $url, $type = "get", $data = null) {
        if($type === "get") {
            $resultJson = $this->myCurlGet($url);
        } else {
            $resultJson = $this->myCurlPost($url, $data);
        }

        $resultArray = json_decode($resultJson, true);

        //记录日志
        $this->recordLogs($method, $resultJson);

        return $resultArray;
    }

    /**
     * 记录日志
     * @param $method
     * @param $resultMessage
     * @param string $myMessage
     * @param string $level
     */
    public function recordLogs($method, $resultMessage = "", $myMessage = "", $level = "log") {
        $condtions = array(
            'method' => $method,
            'result_message' => $resultMessage,
            'my_message' => $myMessage,
            'level' => $level,
            'add_time' => date("Y-m-d H:i:s",time()),
        );

        $this->insertLogsInfo($condtions);
    }

    /**
     * 接口调用日志入库
     * @param $condtions
     * @return mixed
     */
    public function insertLogsInfo($condtions) {
        $sql = "INSERT wn_jingdong_api_request_logs (method,result_message,my_message,`level`,add_time) values('{$condtions['method']}','{$condtions['result_message']}','','{$condtions['level']}','{$condtions['add_time']}')";
        Yii::$app->wnmall->createCommand($sql)->execute();
        return Yii::$app->wnmall->getLastInsertID();
    }

    /**
     * Curl发送get请求, 支持HTTPS协议
     * @param string $url
     * @return mixed
     */
    public function myCurlGet($url) {
        // 创建一个新cURL资源
        $ch = curl_init();

        // 设置URL和相应的选项
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_HEADER, false);
        curl_setopt($ch, CURLOPT_FAILONERROR, false);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_USERAGENT, $_SERVER['HTTP_USER_AGENT'] );
        curl_setopt($ch, CURLOPT_TIMEOUT,60);

        //支持https 请求
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);

        // 抓取URL并把它传递给浏览器
        $reponse = curl_exec($ch);

        // 关闭cURL资源，并且释放系统资源
        curl_close($ch);

        return $reponse;
    }

    /**
     * Curl发送post请求, 支持HTTPS协议
     * @param string $url
     * @param string json $data
     * @return mixed
     */
    public function myCurlPost($url, $data) {
        // 创建一个新cURL资源
        $ch = curl_init();

        // 设置URL和相应的选项
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_HEADER, false);
        curl_setopt($ch, CURLOPT_FAILONERROR, false);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        if(isset($_SERVER['HTTP_USER_AGENT']) && !empty($_SERVER['HTTP_USER_AGENT'])) {
            curl_setopt($ch, CURLOPT_USERAGENT, $_SERVER['HTTP_USER_AGENT'] );
        }
        curl_setopt($ch, CURLOPT_TIMEOUT,60);

        //支持https 请求
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);

        // post提交方式
        curl_setopt($ch, CURLOPT_POST, TRUE);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $data);

        // 抓取URL并把它传递给浏览器
        $reponse = curl_exec($ch);

        // 关闭cURL资源，并且释放系统资源
        curl_close($ch);

        return $reponse;
    }

    /**
     * 对数组进行分页
     * @param $sourceArray 源数组
     * @param $elementSize 分页大小
     * @return array
     */
    public function arrayPagination($sourceArray, $elementSize) {
        $elementCount = count($sourceArray);
        $elementGroupCount = ceil($elementCount / $elementSize);
        $allGroupList = array();
        $oneGroupList = array();
        for($i = 0; $i < $elementGroupCount; $i ++) {
            $startOffset = $i * $elementSize;
            $oneGroupList = array_slice($sourceArray, $startOffset, $elementSize);
            $allGroupList[] = $oneGroupList;
        }

        return $allGroupList;
    }

}