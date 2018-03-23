<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/11/3
 * Time: 13:47
 */

namespace common\classes;


use common\helpers\Func;

class KuaiqianClient
{
    private $merid;
    private $merkey;
    public function __construct (){
        $this->merid = Func::param('kuaiqian', 'mer_id');
        $this->merkey = Func::param('kuaiqian', 'mer_key');
    }

    public function bankPay( $withdraw ){

        $amount         = abs($withdraw['dzamount']);
        $province_city  = $withdraw['bankcity'];
        $bankName       = $withdraw['bankname'];
        $kaihuhang      = $withdraw['bankdeposit'];
        $creditName     = $withdraw['realname'];
        $bankCardNumber = $withdraw['bankcardno'];
        $orderId        = $withdraw['withdraw_sn'];

        $kq_para = $bankCardNumber . $amount . $orderId . $this->merkey;
        $mac = strtoupper(md5($kq_para));
        $para = array (
            'province_city'   => $province_city,
            'bankName'        => $bankName,
            'kaihuhang'       => $kaihuhang,
            'creditName'      => $creditName,
            'bankCardNumber'  => $bankCardNumber,
            'description'     => '',
            'amount'          => $amount,
            'orderId'         => $orderId,
            'mac'             => $mac
        );
        $postArray = array(
            array(
                $para
            ),
            $this->merid
        );
        libxml_disable_entity_loader(false);
        $opts = array(
            'ssl'   => array(
                    'verify_peer'          => false
                ),
            'https' => array(
                    'curl_verify_ssl_peer'  => false,
                    'curl_verify_ssl_host'  => false
             )
        );
        $streamContext = stream_context_create($opts);

        $clientObj = new \SoapClient("https://www.99bill.com/webapp/services/BatchPayWS?wsdl", array('exceptions'=>false, 'trace' => false, 'stream_context'=> $streamContext));

        try {
            $result = $clientObj->__soapCall("bankPay", $postArray);
            $result = $result[0];
            $resultArr = json_decode(json_encode($result), true);

            if ($resultArr['resultFlag'] || $resultArr['failureCause'] == 5212 ) {
                //成功了
                $dealId = $resultArr['dealId'];
                return [1, $dealId];
            } else {
                //失败
                return [0, json_encode($result, JSON_UNESCAPED_UNICODE)];
            }

        } catch (\SOAPFault $e) {

            $error = $e->getMessage();
            return [0, $error];
        }

    }

    public function queryDeal( $withdraw ){

        $orderId = $withdraw['withdraw_sn'];

        $para = array(
            'dealId' => "0",
            'queryType' => "bankPay",
            'orderId' => $orderId
        );
        $postArray = array(
            $para,
            $this->merid,
        );

        libxml_disable_entity_loader(false);
        $opts = array(
            'ssl'   => array(
                'verify_peer'          => false
            ),
            'https' => array(
                'curl_verify_ssl_peer'  => false,
                'curl_verify_ssl_host'  => false
            )
        );
        $streamContext = stream_context_create($opts);

        $clientObj = new \SoapClient("https://www.99bill.com/webapp/services/BatchPayWS?wsdl", array('exceptions'=>false, 'trace' => false, 'stream_context'=> $streamContext));
        $result = $clientObj->__soapCall("queryDeal", $postArray);
        $result = $result[0];

        if( $result->resultFlag ){
            if( $result->dealStatus == 111) {//成功
                return [111, '成功'];
            }else{//其他
                return [$result->dealStatus, json_encode($result, JSON_UNESCAPED_UNICODE)];
            }
        }else{
            return [0, json_encode($result, JSON_UNESCAPED_UNICODE)];
        }
    }
}