<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="/mobile/20171023/css/style.css">
    <title>累计收入</title>
</head>

<body class="sum_bg">
<?php if(\common\helpers\Func::getPT() == 'web'): ?>
<nav class="sum_header">
    <a href="javascript:history.go(-1)" class='sum_back'></a>
    <span>累计收入</span>
</nav>
<?php endif;?>
<div class="sum_shortcut">
    <p>
        <span>累计收入</span>（元）</p>
    <h3 class="total"><?=$totalIncome ?></h3>
</div>
<ul class="sum_state">
    <li>日期</li>
    <li>状态</li>
    <li>数量</li>
</ul>
<?php if(!empty($mgqList)){?>
<ul class="sum_list">
    <?=\member\modules\m\widgets\MgqListWidget::widget(['mgqList' => $mgqList])?>
</ul>
<div class="sum_more">
    <span>更多</span>
</div>
<?php }else{?>
<div class="sum_no_data">
    <div></div>
    <span>什么都没有呢(⊙o⊙)…</span>
</div>
<?php }?>
<script src="/mobile/20171023/js/jquery-1.10.2.js"></script>
<script src="/mobile/20171023/js/pt.js"></script>
<script type="text/javascript">
    var page = 2;
    $('.sum_more span').click(function(){
        $.getJSON('<?=\yii\helpers\Url::toRoute(['mgq-list', 'date' => $date])?>', {ajax:1, page:page}, function(data){

            if(page > data.pageCount){
                $('.sum_more').hide();
            }else{
                $('ul.sum_list').append(data.html);
                page++;
            }
        });
    });
</script>
</body>

</html>