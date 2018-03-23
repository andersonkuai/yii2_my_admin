<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/11/6
 * Time: 16:41
 */

namespace common\classes\ylmg;


use yii\base\Component;

class YlmgSupportHttp extends Component implements YlmgSupportInterface
{

    public function isSeller($uid)
    {
        // TODO: Implement isSeller() method.
    }

    public function register( $mobile, $tguid, $fund_uid ){

    }
    public function getUserByMobile( $mobile ){

    }
    public function updateUser( $id, $data ){

    }
}