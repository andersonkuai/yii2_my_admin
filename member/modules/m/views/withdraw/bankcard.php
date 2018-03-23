<?php
use yii\helpers\Url;
?>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="/mobile/20171023/css/style.css?_=20171102">
    <link rel="stylesheet" href="/mobile/20171023/css/iconfont.css">
    <link rel="stylesheet" href="/mobile/20171023/font.css">
    <title>我的银行卡</title>
</head>

<body>
<?php if(\common\helpers\Func::getPT() == 'web'): ?>
<nav class="sum_header">
    <a href="javascript:history.go(-1)" class='sum_back'></a>
    <span>我的银行卡</span>
</nav>
<?php endif;?>
<!-- <svg class="bank" aria-hidden="true">
    <use xlink:href="#icon-guangfa"></use>
    中行#icon-zhonghang  建行#icon-jianhang  农行#icon-nonghang  #工行icon-gonghang  平安银行#icon-pinganyinhang  光大#icon-guangda  华夏#icon-huaxia  中信#icon-zhongxin
    招行#icon-zhaohang  邮政#icon-youzheng  民生#icon-minsheng  浦发#icon-pufa  广发#icon-guangfa  兴业#icon-xingye   交行#icon-jiaohang
</svg> -->
<ul class="card_lists">
    <?php foreach($list as $row){
        $bank = \common\helpers\Func::param('bankcard', $row['bankid']);
        ?>
        <li class="card_item">
            <a href="#">
                <i class="iconfont bank" style="color: <?=$bank['color']?>"><?=$bank['font']?></i>
                <div class="card_info">
                    <p><?=$row['bankname']?></p>
                    <p><?= substr_replace($row['bankcardno'], "******", 6, 6)?></p>
                </div>
            </a>
            <i class="delete" onclick="deleteCard(<?=$row['id']?>, this)"></i>
        </li>
    <?php }?>
</ul>
<div class="add_card">
    <a href="<?=Url::toRoute(['bankcard-add'])?>" class="card_add" onclick="return PT.open('<?=Url::toRoute(['bankcard-add'], true)?>', '添加银行卡')">添加银行卡</a>
</div>
<div class="cards_bg">
</div>
<script src="/mobile/20171023/js/jquery.min.js"></script>
<script src="/mobile/20171023/js/pt.js"></script>
<script type="text/javascript">
    function deleteCard(id, elem){

        $.getJSON('<?=\yii\helpers\Url::toRoute(['bankcard-delete'])?>', {id:id}, function(data){

            if(data.code == 1){
                $(elem).parent('li.card_item').remove();
            }else{
                alert(data.msg);
            }
        });
    }
</script>
</body>

</html>