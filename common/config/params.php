<?php
return [
    'adminEmail' => 'admin@example.com',
    'supportEmail' => 'support@example.com',
    'user.passwordResetTokenExpire' => 3600,

    'admin.status' => [
        0 => '禁用', 10 => '正常'
    ],
    'user.status' => [
        0 => '禁用', 10 => '正常'
    ],
    'user.membertype' => [
        0 => '注册会员', 1 => '铜牌会员', 2 => '银牌会员', 3 => '金牌会员', 4 => '钻石会员'
    ],
    'user.level' => [
        1 => '区域代理', 2 => '区域二级代理',
    ],
    'user.downline_level' => [
        2 => '区域二级代理',
    ],
    'agent.agency_level' => [
        1 => '省',
        2 => '市',
        3 => '区/县',
    ],
    'agent.type' => [
        1 => '自然人LP',
        2 => '投资者GP',
    ],
    'agent.identity_type_investor' => [
        1 => '董事长',
        2 => '总经理',
        3 => '总监',
        4 => '部门经理',
    ],
    'agent.identity_type_nature' => [
        5 => '股东',
    ],
    'agent.identity' => [
        1 => '董事长',
        2 => '总经理',
        3 => '总监',
        4 => '部门经理',
        5 => '股东',
    ],
    // 京东对接配置信息
    'jingDongConfig' => array(
        'appKey' => "94f00d1a8f7d499d851cbf4d1fce756b",
        'appSecret' => "6a750ffe435e4d3a8e5ac9d622ad7753",
        'username' => "ylmg2017",
        'password' => "jd123456",
        'mobile' => "15358801936",
        'email' => "jingdong@luogow.com",
        'submitState' => "1",//是否预占库存0是1否
    ),
];
