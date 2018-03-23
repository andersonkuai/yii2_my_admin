<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta content="telephone=no,email=no" name="format-detection">
    <title>支付中心</title>
    <link rel="stylesheet" href="/mobile/20171023/css/style.css" />
</head>
<body>
<?php if(\common\helpers\Func::getPT() == 'web'): ?>
<header>
    <a href="javascript:history.back(-1);"> <img src="/mobile/20171023/images/left.png" /> </a>
    支付中心
</header>
<?php endif;?>
<div class="recha">
    <p> 支付金额 <span style="color:#f60;font-size: 20px;"> <?=sprintf('%.2f', $row['amount']/100);?> </span>元</p>
</div>
<ul class="rechb">
    <li>
        <span> 交易号 </span>  <?=$row['id']?>
    </li>
    <li>
        <span> 内容 </span>  <?=$row['body']?>
    </li>
    <li class="rechb-li">
        <span> 附加备注 </span>  <?=$row['description']?>
    </li>
    <li>
        <span> 选择支付方式 </span>
    </li>
    <li class="rechb-li2">
        <div class="re-pay payactive" data-paytype="redpoint">
            <p> 红积分支付 </p>
            <b> 红积分余额 <i> <?=Yii::$app->user->identity->redpoint;?> </i>
                <?php
                    $rate = \common\helpers\Func::getReturnConfig('red_stock_rates');
                    $payNum = $row['amount'] * (1 + $rate);
                    echo Yii::$app->user->identity->redpoint > $payNum?"需支付{$payNum}红积分":'余额不足';
                ?>
            </b>
        </div>
    </li>
    <li class="rechb-li2">
        <div class="re-pay re-pay2" data-paytype="alipay">
            <p> 支付宝 </p>
        </div>
    </li>
    <li class="rechb-li2" data-paytype="wx" style="display: none">
        <div class="re-pay re-pay2" data-paytype="wx">
            <p> 微信 </p>
        </div>
    </li>
    <li class="rechb-li2">
        <div class="re-pay re-pay2" data-paytype="offline">
            <p> 线下转账 </p>
        </div>
    </li>
</ul>

<a href="javascript:void(0);" class="recha-a" id="paymentBtn"> 提 交 </a>

<script src="/mobile/20171023/js/jquery-1.10.2.js"></script>
<script src="/mobile/20171023/js/main.js"></script>
<script src="/mobile/20171023/js/pt.js"></script>
<script type="text/javascript">
    var CSRF = <?php echo json_encode(['name' => \Yii::$app->request->csrfParam, 'value' => \Yii::$app->request->getCsrfToken()])?>;
    $('#paymentBtn').click(function(){
        var paytype = $('div.payactive').attr('data-paytype');
        var order_sn = '<?=$order_sn?>';
        var postData = [{name:'order_sn',value: order_sn}, {name:'channel',value: paytype}];
        if(typeof CSRF != "undefined") postData.push(CSRF);

        switch (paytype){
            case 'redpoint':
                $.post('/index.php?r=m/payment/redpoint-charge', postData, function(data){
                    if(data.code === 1){
                        alert('充值成功！');
                        //window.location.href = '/index.php?m/point/index';
                        PT.click('goToPreviousPage');
                    }else{
                        alert(data.msg);
                    }
                }, 'json');
                break;
            case 'offline':
                alert('暂未开通，敬请期待');
                break;
            case 'alipay':
            case 'wx':
                if(!PT.isApp()){
                    alert('请在app中打开！');
                    return false;
                }
                //获取ping++ charge对象
                $.post('/index.php?r=m/payment/pingplus-charge', postData, function(data){
                    if(data.code === 1){
                        //alert('获取charge成功：' + JSON.stringify(data.data));
                        PT.click('fundpay', data.data, function(data){
                            alert('充值成功！');
                            //window.location.href = '/index.php?r=m/point/index';
                            PT.click('goToPreviousPage');
                        },function(data){
                            alert('充值失败！');
                        });
                    }else{
                        alert(data.msg);
                    }
                }, 'json');

                break;
            default:
                alert('网络出问题啦！请稍后再试！');
        }

    });
</script>
</body>
</html>