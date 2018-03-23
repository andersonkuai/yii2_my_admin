<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/9/5
 * Time: 14:52
 */

namespace common\classes;



use common\helpers\Curl;
use common\helpers\Func;
use yii\base\InvalidParamException;

class ApiClient
{
    const API_URL = API_URL;
    private $appid;
    private $appsecret;
    private $data = [];

    public function __construct ($appid, $appsecret ){
        $this->appid = $appid;
        $this->appsecret = $appsecret;
    }
    public function setData($data){
        $this->data = $data;
        return $this;
    }
    public function sign(){
        $this->data['appid'] = $this->appid;
        $this->data['sign'] = Func::sign($this->appsecret, $this->data);
        return $this;
    }
    public function get($url){

        $url = $this->getFullUrl($url);
        $url .= '?'.http_build_query($this->data);
        return Curl::curl($url, null, 'GET');
    }
    public function post($url){

        $url = $this->getFullUrl($url);
        return Curl::curl($url, $this->data, 'POST');
    }
    public function put($url){

        $url = $this->getFullUrl($url);
        return Curl::curl($url, $this->data, 'PUT');
    }
    public function delete($url){

        $url = $this->getFullUrl($url);
        return Curl::curl($url, $this->data, 'DELETE');
    }
    private function getFullUrl($url){

        if( stripos($url, 'http') === 0 )
            throw new InvalidParamException('ApiClient::getFullUrl param 1 error!');

        return self::API_URL . '/' . ltrim($url, '/');
    }
}