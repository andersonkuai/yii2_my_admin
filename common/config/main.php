<?php
return [
    'vendorPath' => dirname(dirname(__DIR__)) . '/vendor',
    'components' => [
        'cache' => [
            'class' => 'yii\caching\FileCache',
        ],
//        'db' => [
//            'class' => 'yii\db\Connection',
//            'dsn' => 'mysql:host=192.168.1.19;dbname=management',
//            'username' => 'ylmg',
//            'password' => 'ylmg@1qazxsw2',
//            'charset' => 'utf8',
//        ],
        'db' => [
            'class' => 'yii\db\Connection',
            'dsn' => 'mysql:host=127.0.0.1;dbname=management',
            'username' => 'root',
            'password' => 'WjCn0hAe8BDddB08',
            'charset' => 'utf8',
        ],
        'hiread' => [
            'class' => 'yii\db\Connection',
            'dsn' => 'mysql:host=127.0.0.1;dbname=hiread',
            'username' => 'root',
            'password' => 'WjCn0hAe8BDddB08',
            'charset' => 'utf8',
        ],
        //国际化配置
        'i18n' => [
            'translations' => [
                'app*' => [
                    'class' => 'yii\i18n\PhpMessageSource',
                    //'basePath' => '@app/messages',
                    'sourceLanguage' => 'zh-CN',
                    'fileMap' => [
                        'app' => 'app.php',
                    ],
                ],
            ],
        ],
    ],
    'language' => 'zh-CN',
];
