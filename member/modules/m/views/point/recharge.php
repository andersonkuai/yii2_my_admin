<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta content="telephone=no,email=no" name="format-detection">
    <title>充值库存积分</title>
    <link rel="stylesheet" href="/mobile/20171023/css/style.css" />
</head>
<body>
<?php if(\common\helpers\Func::getPT() == 'web'): ?>
<header>
    <a href="javascript:history.back(-1);"> <img src="/mobile/20171023/images/left.png" /> </a>
    充值库存积分
</header>
<?php endif;?>
<div class="recha">
    <img src="/mobile/20171023/images/kcjf.png" />
    <p> 库存积分余额 <span> <?=Yii::$app->user->identity->stockpoint;?> </span></p>
</div>
<ul class="rechb">
    <li>
        <span> 充值金额 </span>  <input id="rechargeNum" type="text" placeholder="请输入您要充值的库存积分的金额" />
    </li>
    <li class="rechb-li">
        <span> 充值积分 </span>  <input id="rechargePoint" type="text" placeholder="" />
    </li>
</ul>
<a href="javascript:void(0);" class="recha-a"> 提 交 </a>
<script src="/mobile/20171023/js/jquery-1.10.2.js"></script>
<script src="/mobile/20171023/js/main.js"></script>
<script type="text/javascript">
    var CSRF = <?php echo json_encode(['name' => \Yii::$app->request->csrfParam, 'value' => \Yii::$app->request->getCsrfToken()])?>;
    $('#rechargeNum').change(function(){
        var rechargeNum = $(this).val();
        $.getJSON('/index.php?r=m/point/recharge-num', {rechargeNum : rechargeNum}, function(data){
            if(data.code == 1){
                $('#rechargePoint').val(data.data.rechargePoint);
            }else{
                alert(data.msg);
            }
        });
    });
    $('a.recha-a').click(function(){
        var that = this;
        if($(that).hasClass('disabled')) return;
        var recharge_money = $('#rechargeNum').val();
        var postData = [{name:'recharge_money',value: recharge_money}];
        if(typeof CSRF != "undefined") postData.push(CSRF);
        $(that).addClass('disabled');
        $.post('/index.php?r=m/point/recharge-create', postData, function(data){
            if(data.code === 1){
                window.location.href="?r=m/point/recharge-pay&recharge_sn="+data.data.recharge_sn;
            }else{
                alert(data.msg);
                $(that).removeClass('disabled');
            }
        }, 'json');
    });
</script>
</body>
</html>