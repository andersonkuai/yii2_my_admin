<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/8/21
 * Time: 10:04
 */

namespace member\helpers;


use common\helpers\Url;

class Utility
{
    public static function userAvatar( $uri ){

        if(empty($uri))
            return '/adminlte/dist/img/user2-160x160.jpg';
        return Url::image($uri);
    }
}