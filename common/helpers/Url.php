<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/8/24
 * Time: 16:43
 */

namespace common\helpers;


class Url
{
    const VERSION = '20180101.0000';
    public static function image( $uri ){

        if( stripos($uri, 'http') === 0 ) return $uri;

        return STATIC_URL . $uri;
    }
    public static function css( $uri ) {
        return STATIC_URL . $uri . "?v=" . self::VERSION;
    }
    public static function js( $uri ) {
        return STATIC_URL . $uri . "?v=" . self::VERSION;
    }
}