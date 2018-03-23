<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="/mobile/20171023/css/style.css?_=20171102">
    <link rel="stylesheet" href="/mobile/20171023/css/iconfont.css">
    <link rel="stylesheet" href="/mobile/20171023/font.css">
    <title>添加银行卡</title>
</head>

<body>
<?php if(\common\helpers\Func::getPT() == 'web'): ?>
<nav class="sum_header">
    <a href="javascript:history.go(-1)" class='sum_back'></a>
    <span>添加银行卡</span>
</nav>
<?php endif;?>
<!-- <svg class="bank" aria-hidden="true">
    <use xlink:href="#icon-guangfa"></use>
    中行#icon-zhonghang  建行#icon-jianhang  农行#icon-nonghang  #工行icon-gonghang  平安银行#icon-pinganyinhang  光大#icon-guangda  华夏#icon-huaxia  中信#icon-zhongxin
    招行#icon-zhaohang  邮政#icon-youzheng  民生#icon-minsheng  浦发#icon-pufa  广发#icon-guangfa  兴业#icon-xingye   交行#icon-jiaohang
</svg> -->
<div class="add_form">
    <div class="step1">
        <p>持卡人姓名</p>
        <input type="text" placeholder="请输入持卡人姓名" id="realname">
        <p>身份证号码</p>
        <input type="text" placeholder="请填写身份证号" id="identitycardno">

        <button type="button" class="next">下一步</button>
    </div>
    <div class="step2">
        <p>填写银行卡信息</p>
        <div style="position:relative">
            <input type="hidden" name="bankid" value="0" id="bankid">
            <input type="hidden" name="bankname" value="0" id="bankname">
            <input type="text" readonly onfocus="this.blur()" class="mainBank" placeholder="请选择银行" onclick="showBank()">
            <i class="choose_bank"></i>
        </div>
        <input type="text" placeholder="请填写开户行城市" id="bankcity">
        <input type="text" placeholder="请填写开户行" id="bankdeposit">
        <p>银行卡号</p>
        <input type="number" placeholder="请填写银行卡号" id="bankcardno">
        <p>银行预留手机号</p>
        <input type="number" placeholder="请填写银行预留手机号" id="mobile">
        <button type="button" class="pre">返回</button>
        <button type="button" class="pre_submit" onclick="confirmInfo()">提交</button>
    </div>
</div>
<div action="" class="confirmForm">
    <p>
        持卡人姓名：
        <span id="span-realname"></span>
    </p>
    <p>
        身份证号：
        <span id="span-identitycardno"></span>
    </p>
    <p>
        银行卡号：
        <span id="span-bankcardno"></span>
    </p>
    <p>
        所属银行：
        <span id="span-bankname"></span>
    </p>
    <p>
        开户行：
        <span id="span-bankdeposit"></span>
    </p>
    <p>
        手机号：
        <span id="span-mobile"></span>
    </p>
    <button class="button" id="submitBtn">
        确认信息
    </button>
</div>

<div class="bank_list">
    <p>选择银行</p>
    <ul>
        <?php
        $banks = \common\helpers\Func::params('bankcard');
        foreach ($banks as $bankid =>$bank){?>
        <li class="bank_item" data-id="<?=$bankid?>">
            <i class="iconfont bank" style="color: <?=$bank['color']?>"><?=$bank['font']?></i>
            <span><?=$bank['name']?></span>
        </li>
        <?php }?>

    </ul>
</div>
<div class="bank_list_bg"></div>

<div class="add_card_bg"></div>
<script src="/mobile/20171023/js/jquery.min.js"></script>
<script src="/mobile/20171023/js/pt.js"></script>
<script>
    var postData = {
        '<?= \Yii::$app->request->csrfParam;?>':'<?= \Yii::$app->request->getCsrfToken();?>',
        realname:'',
        identitycardno:'',
        bankid:'',
        bankname:'',
        bankcity:'',
        bankdeposit:'',
        bankcardno:'',
        mobile:'',
    };

    $('.add_form .next').click(function () {
        postData.realname = $('#realname').val();
        postData.identitycardno = $('#identitycardno').val();

        if(!postData.realname){
            alert('请填写持卡人姓名！');
            return false;
        }
        if(!postData.identitycardno){
            alert('请填写持卡人身份证号！');
            return false;
        }
        $('.step1,.step2').toggle()
    })
    $('.add_form .pre').click(function () {
        $('.step2 input').val('')
        $('.step1,.step2').toggle()
    })

    function showBank() {
        $('.bank_list,.bank_list_bg').toggle()
    }
    function confirmInfo(){
        postData.bankid = $('#bankid').val();
        postData.bankname = $('#bankname').val();
        postData.bankcity = $('#bankcity').val();
        postData.bankdeposit = $('#bankdeposit').val();
        postData.bankcardno = $('#bankcardno').val();
        postData.mobile = $('#mobile').val();

        if(postData.bankid == 0 || postData.bankid == ''){
            alert('请选择银行！');
            return false;
        }
        if(!postData.bankcity){
            alert('请填写开户行城市！');
            return false;
        }
        if(!postData.bankdeposit){
            alert('请填写开户行！');
            return false;
        }
        if(!postData.bankcardno){
            alert('请填写银行卡卡号！');
            return false;
        }
        if(!postData.mobile){
            alert('请填写银行预留手机号！');
            return false;
        }

        $('#span-realname').text(postData.realname);
        $('#span-identitycardno').text(postData.identitycardno);
        $('#span-bankname').text(postData.bankname);
        $('#span-bankcardno').text(postData.bankcardno);
        $('#span-bankdeposit').text(postData.bankdeposit);
        $('#span-mobile').text(postData.mobile);

        $('.confirmForm,.bank_list_bg').toggle()
    }
    $('.bank_list_bg').click(function(){
        $('.bank_list_bg,.confirmForm,.bank_list').hide()
    })
    $(document).ready(function () {
        $('.bank_list .bank_item').mousedown(function () {
            var tmp = $(this).children('span').text();
            $('.mainBank').val(tmp);
            $('#bankid').val($(this).attr('data-id'));
            $('#bankname').val(tmp);
            $('.bank_list,.bank_list_bg').toggle()
        });

        $('#submitBtn').click(function(){

            $.post('<?=\yii\helpers\Url::toRoute('bankcard-add')?>', postData, function(data){

                if( data.code == 1 ){
                    //window.location.href = '<?=\yii\helpers\Url::toRoute('bankcard')?>';
                    PT.click('goToPreviousPage');
                }else{
                    alert(data.msg);
                }
            },'json');

        });
    })
</script>

</body>

</html>