<?php use yii\helpers\Url;?>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width,user-scalable=no" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <link rel="stylesheet" type="text/css" href="/mobile/20171023/addcard/reset.css"/>
    <link rel="stylesheet" href="/mobile/20171023/font.css">
    <title>申请提现</title>
</head>
<body>
<?php if(\common\helpers\Func::getPT() == 'web'): ?>
<header>
    <a href="javascript:void(0)">返回</a>
    <span>申请提现</span>
</header>
<?php endif;?>
<a href="javascript:void(0)" class="chose-card">选择银行卡 <span></span></a>
<?php
$bankcard = empty($bankcardList[0]) ? [] : $bankcardList[0];
if(!empty($bankcard)){
    $bank = \common\helpers\Func::param('bankcard', $bankcard['bankid']);
?>
<a href="javascript:void(0)" class="clearfix show-bank" data-id="<?=$bankcard['id']?>" style="color: green;">
    <i class="iconfont" style="color: <?=$bank['color']?>;"><?=$bank['font']?></i>
    <p class="show-content"><i><?=$bank['name']?></i><br /><span>尾号<?=substr($bankcard['bankcardno'], -4)?>储蓄卡</span></p>
    <i class="iconfont">&#xe633;</i>
</a>
<?php }?>
<div class="mey">
    <label for="money">金额</label><input type='number' id="money" placeholder="单笔提现金额不少于5元"/>
</div>
<p class="detal">您当前可以可以提现<span>￥<?= \Yii::$app->user->identity->balance ?></span>元，手续费3%</p>
<a href="javascript:void(0)" class="tx-btn">确认提现</a>
<p class="ts"><b>特别提示：</b>最低提现金额5元/次，三个工作日内到账，银行收取提现手续费3%每笔，不满2元按2元计算</p>

<!--选择银行卡弹窗-->
<div class="modal-card">
    <div class="modal-content">
        <div class="modal-header">
            <a href="<?=Url::toRoute(['bankcard-add'])?>" onclick="return PT.open('<?=Url::toRoute(['bankcard-add'], true)?>', '添加银行卡')">+</a>
            <span>选择银行卡</span>
        </div>
        <div class="modal-body">
            <input type="hidden" name="" id="bankcardid" value="<?=!empty($bankcard['id'])?$bankcard['id']:0?>" />

            <?php foreach ($bankcardList as $bankcard){
                $bank = \common\helpers\Func::param('bankcard', $bankcard['bankid']);
                ?>
                <a href="javascript:void(0)" class="clearfix" data-id="<?=$bankcard['id']?>">
                    <i class="iconfont bank-card-i" style="color: <?=$bank['color']?>;"><?=$bank['font']?></i>
                    <p><i><?=$bank['name']?></i><br /><span>尾号<?=substr($bankcard['bankcardno'], -4)?>储蓄卡</span></p>
                    <i class="iconfont">&#xe633;</i>
                </a>
            <?php }?>
        </div>
    </div>
</div>
<script src="/mobile/20171023/js/jquery.min.js"></script>
<script src="/mobile/20171023/js/pt.js"></script>
<script type="text/javascript">
    $(function(){
        $(".chose-card").click(function(){
            $(".modal-card").css("display","block");
        });
        $(".modal-body>a").click(function(){
            var m = $(".modal-body>a").index(this);
            var ico = $(".modal-body>a").eq(m).children(".bank-card-i").text();
            var color = $(".modal-body>a").eq(m).children(".bank-card-i").css("color");
            var p1 = $(".modal-body>a").eq(m).children("p").find("i").text();
            var p2 = $(".modal-body>a").eq(m).children("p").find("span").text();
            console.log(p2)
            $(this).addClass("on").siblings().removeClass("on");
            $(".modal-card").css("display","none");
//				alert($(".on>i").eq(0).text());
            $(".show-bank>i").eq(0).text(ico);
            $(".show-bank>i").eq(0).css("color",color);
            $(".show-content").eq(0).children("i").text(p1);
            $(".show-content").eq(0).children("span").text(p2);

            $('#bankcardid').val($(this).attr('data-id'));

        });

        $('a.tx-btn').click(function(){

            var bankcardid = $('#bankcardid').val();
            var money = $('#money').val();

            if(bankcardid == 0 || bankcardid == ''){
                alert('请选择正确的银行卡！');
                return false;
            }
            if(money == '' || money < 5){
                alert('请填写正确的提现金额！');
                return false;
            }
            var postData = {
                '<?= \Yii::$app->request->csrfParam;?>':'<?= \Yii::$app->request->getCsrfToken();?>',
                bankcardid:bankcardid,
                money:money
            }
            $.post('<?=Url::toRoute(['index'])?>', postData, function(data){

                if(data.code == 1){
                    //window.location.href = '<?=\yii\helpers\Url::toRoute('index')?>';
                    PT.click('goToPreviousPage');
                }else{
                    alert(data.msg);
                }

            }, 'json');
        });
    })
</script>
</body>
</html>