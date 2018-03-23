
<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>
        <?=\Yii::t('app','控制面板')?>
<!--        <small>最后统计时间 --><?php //echo date("Y-m-d H:i:s", $statistics['created'])?><!--</small>-->
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> <?=\Yii::t('app','主页')?></a></li>
        <li class="active"><?=\Yii::t('app','控制台')?></li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <!-- Small boxes (Stat box) -->
    <div class="row">
        <div class="col-lg-3 col-xs-6">
            <!-- small box -->
<!--            <div class="small-box bg-aqua">-->
<!--                <div class="inner">-->
<!--                    <span><font style="font-size: 40px">--><?//=$activated_count?><!--</font>笔</span>-->
<!---->
<!--                    <p>今日激活</p>-->
<!--                </div>-->
<!--                <div class="icon">-->
<!--                    <i class="ion ion-person-stalker"></i>-->
<!--                </div>-->
<!--                --><?php //$totay = date('Y-m-d');?>
<!--                <a href="?r=user/index&is_activated=1&activated_time=--><?php //echo $totay;?><!--" class="small-box-footer">查看更多 <i class="fa fa-arrow-circle-right"></i></a>-->
<!--            </div>-->
        </div>

        <div class="col-lg-3 col-xs-6">
            <!-- small box -->
<!--            <div class="small-box bg-aqua">-->
<!--                <div class="inner">-->
<!--                    <span><font style="font-size: 40px">--><?//=$consume_count?><!--</font>笔</span>-->
<!--                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-->
<!--                    <span><font style="font-size: 40px">--><?//=$money?><!--</font>元</span>-->
<!---->
<!--                    <p>今日订单</p>-->
<!--                </div>-->
<!--                <div class="icon">-->
<!--                    <i class="ion ion-bag"></i>-->
<!--                </div>-->
<!--                <a href="javascript:void(0)" class="small-box-footer"><i class="fa "></i></a>-->
<!--            </div>-->
        </div>
    </div>
    <!-- /.row -->
</section>
<!-- /.content -->
<script type="text/javascript" src="/plugins/cookie/js/jsapi.js"></script>
<script type="text/javascript" src="/plugins/cookie/js/corechart.js"></script>
<script type="text/javascript" src="/plugins/cookie/js/jquery.gvChart-1.0.1.min.js"></script>
<script type="text/javascript" src="/plugins/cookie/js/jquery.ba-resize.min.js"></script>
