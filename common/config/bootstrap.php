<?php
Yii::setAlias('@common', dirname(__DIR__));
Yii::setAlias('@api', dirname(dirname(__DIR__)) . '/api');
Yii::setAlias('@backend', dirname(dirname(__DIR__)) . '/backend');
Yii::setAlias('@console', dirname(dirname(__DIR__)) . '/console');
Yii::setAlias('@member', dirname(dirname(__DIR__)) . '/member');
Yii::setAlias('@static', dirname(dirname(__DIR__)) . '/static');

if( !defined('STATIC_URL') ) define('STATIC_URL', 'http://static.management.com');
//if( !defined('API_URL') ) define('API_URL', 'http://agency-static.yunlianmeigou.com');
