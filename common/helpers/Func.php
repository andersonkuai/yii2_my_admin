<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/8/24
 * Time: 16:39
 */

namespace common\helpers;

use Yii;
use common\models\SysConfig;
use common\models\GlobalStatistics;
use yii\base\InvalidParamException;

class Func
{
    public static function checkMobile($mobile){

        if(!$mobile || strlen($mobile) != 11) return false;

        $str_mate = "/^(0|86|17951)?(13[0-9]|14[57]|15[012356789]|166|17[03678]|18[0-9]|19[89])[0-9]{8}$/";
        $r = preg_match_all($str_mate,$mobile);
        if(!$r) return false;

        return true;
    }
    //todo
    public static function checkVerifyCode( $code, $mobile ){

        return $code == 8888 ? true : false;
    }

    public static function params($paramKey){

        return isset(Yii::$app->params[$paramKey]) ?
            Yii::$app->params[$paramKey] : null;
    }
    public static function param($paramKey, $key){

        $params = self::params($paramKey);
        return isset($params[$key]) ? $params[$key] : null;
    }
    public static function sign( $secret, $arr ){

        ksort($arr);
        $str = '';
        foreach( $arr as $key=>$value ){
            if( !is_string($value) && !is_numeric($value) )
                throw new InvalidParamException('expects param 2 array value to be string,array given.');
            $str.= $key . '=' . $value . '&';
        }
        return sha1($str.$secret);
    }

    public static function checkSign( $data, $keys = null ){

        if(empty($data['appid']) || empty($data['sign'])) return false;
        $appid = $data['appid'];
        $sign = $data['sign'];
        $app = self::param('system.app', $appid);

        unset($data['sign']);
        if( $keys ){
            foreach($data as $key => $value){
                if( !in_array($key, $keys) ) unset($data[$key]);
            }
        }
        $newSign = self::sign($app['appsecret'] , $data);

        return $sign == $newSign;
    }
    public static function getClientIp()
    {
        switch(true){
            case ($ip=getenv("HTTP_X_FORWARDED_FOR")):
                break;
            case ($ip=getenv("HTTP_CLIENT_IP")):
                break;
            default:
                $ip=getenv("REMOTE_ADDR")?getenv("REMOTE_ADDR"):'127.0.0.1';
        }
        if (strpos($ip, ', ')>0) {
            $ips = explode(', ', $ip);
            $ip = $ips[0];
        }
        return $ip;
    }

    public static function getReturnConfig( $name ){
        $configs = self::params('return_config');

        return isset($configs[$name]) ? $configs[$name] : 0;
    }

    public static function resubmit(){
        $keyName = 'submit.time';
        $time = intval(Yii::$app->getSession()->get($keyName));
        if($time && (time() - $time < 3) ) return true;
        Yii::$app->getSession()->set($keyName, time());
        return false;
    }

}