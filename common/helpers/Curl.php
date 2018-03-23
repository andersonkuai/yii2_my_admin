<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/9/4
 * Time: 17:42
 */

namespace common\helpers;


use yii\base\Exception;

class Curl
{
    public static function curl($url, $postFields = null, $method = 'GET', $readTimeout = 30, $connectTimeout = 30 )
    {
        $header = ["content-type: application/x-www-form-urlencoded; charset=UTF-8"];

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_FAILONERROR, false);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch,CURLOPT_HTTPHEADER,$header);
        curl_setopt($ch,CURLOPT_USERAGENT, "fund-sdk-php" );
        if ($readTimeout) curl_setopt($ch, CURLOPT_TIMEOUT, $readTimeout);
        if ($connectTimeout) curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, $connectTimeout);
        //https 请求
        if(strlen($url) > 5 && strtolower(substr($url,0,5)) == "https" ) {
            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
            curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
        }
        switch($method) {
            case 'GET':
                break;
            case 'POST':
                curl_setopt($ch, CURLOPT_POST, true);
                break;
            case 'PUT':
                curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'PUT');
                break;
            case 'DELETE':
                curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'DELETE');
                break;
        }

        if ($method != 'GET' && is_array($postFields) && 0 < count($postFields)){
            $postBodyString = "";
            foreach ($postFields as $k => $v)
            {
                $v = (string)$v;
                if(!is_string($v)) continue ;
                $postBodyString .= "$k=" . urlencode($v) . "&";
            }
            curl_setopt($ch, CURLOPT_POSTFIELDS, substr($postBodyString,0,-1));
        }
        $response = curl_exec($ch);

        if (curl_errno($ch)) {
            throw new Exception(curl_error($ch),0);
        }
        curl_close($ch);
        return $response;
    }
}