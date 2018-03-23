<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/10/28
 * Time: 13:56
 */

namespace common\enums;

use common\helpers\Enum;

class User extends Enum
{
    //用户状态
    const USERSTATUS_REGIST = 'regist';
    const USERSTATUS_TRY = 'try';
    const USERSTATUS_CHARGE = 'charge';

    public static function labels(){

        return [
            'USERSTATUS_REGIST' => '注册用户',
            'USERSTATUS_TRY' => '试听用户',
            'USERSTATUS_CHARGE' => '付费用户',
        ];
    }
}