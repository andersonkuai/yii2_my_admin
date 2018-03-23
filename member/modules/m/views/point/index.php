<?php
use yii\helpers\Url;
?>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0,user-scalable=no" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>积分账户</title>
    <link rel="stylesheet" href="/mobile/20171023/css/reset.css" />
    <script type="text/javascript">
        (function(){
            var html = document.documentElement;
            var width = html.getBoundingClientRect().width;
            if(width<670){
                html.style.fontSize = width/15+"px";
            }
        })();
    </script>
</head>
<body>
<?php if(\common\helpers\Func::getPT() == 'web'): ?>
<header>
    <a href="javascript:history.go(-1)"> <img src="/mobile/20171023/images/left.png" /> </a>
    积分账户
    <a href="<?=\yii\helpers\Url::toRoute('list')?>">积分明细</a>
</header>
<?php endif;?>
<nav id="nav">
    <ul>
        <li<?=$pointType=='white'?' class="ative"':''?>>白积分</li>
        <li<?=$pointType=='red'?' class="ative"':''?>>红积分</li>
        <li<?=$pointType=='stock'?' class="ative"':''?>>库存积分</li>
    </ul>
</nav>
<div class="item <?=$pointType=='white'?'tive':''?>" style="display: none;">
    <img src="/mobile/20171023/images/bjf.png"/>
    <p>白积分余额</p>
    <h3><?=\Yii::$app->user->identity['whitepoint']?></h3>
    <div class="common white">
        <a href="<?=Url::toRoute(['exchange-white-balance'])?>" onclick="return PT.open('<?=Url::toRoute(['exchange-white-balance'], true)?>', '兑换美购券');">兑换</a>
    </div>
</div>
<div class="item <?=$pointType=='red'?'tive':''?>" style="display: none;">
    <img src="/mobile/20171023/images/hjf.png"/>
    <p>红积分余额</p>
    <h3><?=\Yii::$app->user->identity['redpoint']?></h3>
    <div class="common common2">
        <a href="<?=Url::toRoute(['exchange-red-balance'])?>" onclick="return PT.open('<?=Url::toRoute(['exchange-red-balance'], true)?>', '兑换美购券');">兑换</a>
        <div class="clear"></div>
    </div>
</div>
<div class="item <?=$pointType=='stock'?'tive':''?>"style="display: none;">
    <img src="/mobile/20171023/images/kcjf.png"/>
    <p>库存积分余额</p>
    <h3><?=\Yii::$app->user->identity['stockpoint']?></h3>
    <div class="common common3">
        <a href="<?=Url::toRoute(['recharge'])?>" onclick="return PT.open('<?=Url::toRoute(['recharge'], true)?>', '充值库存积分')">充值</a>
        <a href="<?=Url::toRoute(['consume-add'])?>" onclick="return PT.open('<?=Url::toRoute(['consume-add'], true)?>', '收银中心')">收银</a>
    </div>
</div>
<div class="overLay">
    <div>
        <p>暂未开通，敬请期待</p>
        <div class="clearfix">
            <a href="javascript:void(0)" class="not">取消</a>
            <a href="javascript:void(0)" class="ys">确定</a>
        </div>
    </div>
</div>
<script src="/mobile/20171023/js/jquery-1.10.2.js"></script>
<script src="/mobile/20171023/js/pt.js"></script>
<script type="text/javascript">
    $(function(){
        var m = 0;
        $("#nav li").click(function(){
            m = $("#nav li").index(this)
            $(this).addClass("ative").siblings().removeClass("ative");
            $(".item").eq(m).addClass("tive").siblings().removeClass("tive");
        })

//		白积分兑换系统
        /*
        $(".white>a").click(function(){
            alert('暂未开通，敬请期待');return;
            if($(".overLay").css("display")!="block"){
                $(".overLay").css("display","block");
            }
        })
        */
        $(".not").click(function(){
            $(".overLay").css("display","none");
        })
        $(".ys").click(function(){
            $(".overLay").css("display","none");
        })
    })
</script>
</body>
</html>
