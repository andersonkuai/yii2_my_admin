<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta content="telephone=no,email=no" name="format-detection">
    <title>兑换美购券</title>
    <link rel="stylesheet" href="/mobile/20171023/css/style.css" />
</head>
<body>
<?php if(\common\helpers\Func::getPT() == 'web'): ?>
    <header>
        <a href="javascript:history.back(-1);"> <img src="/mobile/20171023/images/left.png" /> </a>
        兑换美购券
    </header>
<?php endif;?>
<div class="recha">
    <img src="/mobile/20171023/images/bjf.png" />
    <p> 白积分余额 <span> <?=Yii::$app->user->identity->whitepoint;?> </span></p>
</div>
<ul class="rechb">
    <li>
        <span> 兑换数量 </span>  <input id="rechargeNum" type="text" placeholder="请输入兑换美购券的白积分数量" />
    </li>
    <li class="rechb-li">
        <span> 美购券 </span>  <input id="balance" type="text" placeholder="" readonly/>
    </li>
</ul>

<a href="javascript:void(0);" class="recha-a"> 兑 换 </a>
<script src="/mobile/20171023/js/jquery-1.10.2.js"></script>
<script src="/mobile/20171023/js/main.js"></script>
<script type="text/javascript">
    var CSRF = <?php echo json_encode(['name' => \Yii::$app->request->csrfParam, 'value' => \Yii::$app->request->getCsrfToken()])?>;
    $('#rechargeNum').change(function(){
        var rechargeNum = $(this).val();
        $.getJSON('/index.php?r=m/point/exchange-balance-num', {rechargeNum : rechargeNum}, function(data){
            if(data.code == 1){
                $('#balance').val(data.data.balance);
            }else{
                alert(data.msg);
            }
        });
    });
    $('a.recha-a').click(function(){
        var that = this;
        if($(that).hasClass('disabled')) return;
        var rechargeNum = $('#rechargeNum').val();
        var postData = [{name:'num',value: rechargeNum}];
        if(typeof CSRF != "undefined") postData.push(CSRF);
        $(that).addClass('disabled');
        $.post('/index.php?r=m/point/exchange-white-balance', postData, function(data){
            if(data.code === 1){
                alert(data.msg);
                window.location.href="?r=m/point/index";
            }else{
                alert(data.msg);
                $(that).removeClass('disabled');
            }
        }, 'json');
    });
</script>
</body>
</html>