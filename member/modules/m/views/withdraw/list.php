<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="/mobile/20171023/css/style.css">
    <title>提现记录</title>
</head>

<body class="sum_bg">
<?php if(\common\helpers\Func::getPT() == 'web'): ?>
<nav class="sum_header">
    <a href="javascript:history.go(-1)" class='sum_back'></a>
    <span>提现记录</span>
</nav>
<?php endif;?>
<ul class="sum_state">
    <li>日期</li>
    <li>状态</li>
    <li>金额（元）</li>
</ul>
<?php if(!empty($withdrawList)){?>
    <ul class="sum_list">
        <?=\member\modules\m\widgets\WithdrawListWidget::widget(['withdrawList' => $withdrawList])?>
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
        $.getJSON('<?=\yii\helpers\Url::toRoute(['list', 'date' => $date])?>', {ajax:1, page:page}, function(data){

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