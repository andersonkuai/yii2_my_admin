<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta content="telephone=no,email=no" name="format-detection">
    <title>收银中心</title>
    <link rel="stylesheet" href="/mobile/20171023/css/style.css" />
</head>
<body>
<?php if(\common\helpers\Func::getPT() == 'web'): ?>
    <header>
        <a href="javascript:history.back(-1);"> <img src="/mobile/20171023/images/left.png" /> </a>
        收银中心
    </header>
<?php endif;?>
<div class="recha">
    <img src="/mobile/20171023/images/kcjf.png" />
    <p> 库存积分余额 <span> <?=Yii::$app->user->identity->stockpoint;?> </span></p>
</div>
<ul class="rechb">
    <li>
        <span> 收银用户 </span>  <input id="mguid" type="text" placeholder="请输入商城用户ID/手机号" />
    </li>
    <li>
        <span> 收银金额 </span>  <input id="money" type="text" placeholder="请输入收银金额（元）" />
    </li>
</ul>

<a href="javascript:void(0);" class="recha-a"> 收 银 </a>
<script src="/mobile/20171023/js/jquery-1.10.2.js"></script>
<script src="/mobile/20171023/js/main.js"></script>
<script src="/mobile/20171023/js/pt.js"></script>
<script type="text/javascript">
    var CSRF = <?php echo json_encode(['name' => \Yii::$app->request->csrfParam, 'value' => \Yii::$app->request->getCsrfToken()])?>;
    $('a.recha-a').click(function(){
        var that = this;
        if($(that).hasClass('disabled')) return;
        var money = $('#money').val();
        var mguid = $('#mguid').val();
        var postData = [{name:'mguid', value: mguid }, {name:'money',value: money}];
        if(typeof CSRF != "undefined") postData.push(CSRF);
        $(that).addClass('disabled');
        $.post('/index.php?r=m/point/consume-add', postData, function(data){
            if(data.code === 1){
                alert(data.msg);
                //window.location.href="?r=m/point/index";
                PT.click('goToPreviousPage');
            }else{
                alert(data.msg);
                $(that).removeClass('disabled');
            }
        }, 'json');
    });
</script>
</body>
</html>