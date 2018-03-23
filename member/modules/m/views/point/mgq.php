<?php
use yii\helpers\Url;
?>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width,user-scalable=no" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>我的美购券</title>
    <link rel="stylesheet" type="text/css" href="/mobile/20171023/css/mgq.css"/>
</head>
<body>
<?php if(\common\helpers\Func::getPT() == 'web'): ?>
<header>
    <a href="javascript:void(0)">返回</a>
    <span>我的美购券</span>
</header>
<?php endif;?>
<div class="mg-container">
    <div>
        <p>美购券余额</p>
        <p><span><?=sprintf('%.2f', Yii::$app->user->identity->balance)?></span>元</p>
    </div>
    <div class="income">
        <a href="javascript:void(0)"><p><?=$todayIncome?></p><p>今日收入(元)</p></a>
        <span></span>
        <a href="<?=Url::toRoute(['mgq-list', 'date' => date('Ym')])?>" onclick="return PT.open('<?=Url::toRoute(['mgq-list', 'date' => date('Ym')], true)?>', '账单');"><p><?=$monthIncome?></p><p><?=date('m')?>月总收入(元)</p></a>
    </div>
    <ul class="en-list">
        <li><a href="<?=Url::toRoute(['mgq-list'])?>" onclick="return PT.open('<?=Url::toRoute(['mgq-list'], true)?>', '账单');">账单<span></span></a></li>
        <li><a href="<?=Url::toRoute(['withdraw/bankcard'])?>" onclick="return PT.open('<?=Url::toRoute(['withdraw/bankcard'], true)?>', '银行卡');">银行卡<span></span></a></li>
        <li><a href="<?=Url::toRoute(['withdraw/index'])?>" onclick="return PT.open('<?=Url::toRoute(['withdraw/index'], true)?>', '提现');">提现<span></span></a></li>
        <li><a href="<?=Url::toRoute(['withdraw/list'])?>" onclick="return PT.open('<?=Url::toRoute(['withdraw/list'], true)?>', '提现记录');">提现记录<span></span></a></li>
    </ul>
</div>
<script src="/mobile/20171023/js/jquery.min.js"></script>
<script src="/mobile/20171023/js/pt.js"></script>
</body>
</html>