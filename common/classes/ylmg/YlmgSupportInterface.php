<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/11/6
 * Time: 16:36
 */

namespace common\classes\ylmg;


interface YlmgSupportInterface
{
    public function isSeller( $uid );
    public function register( $mobile, $tguid, $fund_uid );
    public function getUserByMobile( $mobile );
    public function updateUser( $id, $data );

}