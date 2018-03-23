<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/10/28
 * Time: 13:56
 */

namespace common\enums;

use common\helpers\Enum;

class Order extends Enum
{
    //支付方式
    const PAY_TYPE_WX = '1';
    const PAY_TYPE_ALI = '2';
    const PAY_TYPE_UNKNOWN = '0';
    //订单状态
    const STATUS_UNPAY = '0';
    const STATUS_PAY = '1';
    const STATUS_FAILED = '2';
    //发货状态
    const SEND_STATUS_NO = '0';
    const SEND_STATUS_SEND = '1';
    const SEND_STATUS_SIGN = '2';


    public static function labels(){

        return [
            'PAY_TYPE_WX' => '微信支付',
            'PAY_TYPE_ALI' => '支付宝支付',
            'PAY_TYPE_UNKNOWN' => '未知',

            'STATUS_UNPAY' => '未支付',
            'STATUS_PAY' => '已支付',
            'STATUS_FAILED' => '支付失败',

            'SEND_STATUS_NO' => '未发货',
            'SEND_STATUS_SEND' => '已发货',
            'SEND_STATUS_SIGN' => '已签收',
        ];
    }
}