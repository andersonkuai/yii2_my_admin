
<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>
        控制面板
        <small><?php echo date("Y-m-d")?></small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> 主页</a></li>
        <li class="active">控制台</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <!-- Small boxes (Stat box) -->
    <div class="row">
        <div class="col-lg-3 col-xs-6">
            <!-- small box -->
            <div class="small-box bg-aqua">
                <div class="inner">
                    <span><font style="font-size: 40px"><?=$consume_count?></font>笔</span>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <span><font style="font-size: 40px"><?=$money?></font>元</span>

                    <p>今日订单</p>
                </div>
                <div class="icon">
                    <i class="ion ion-bag"></i>
                </div>
                <a href="?r=order/index" class="small-box-footer">查看更多 <i class="fa fa-arrow-circle-right"></i></a>
            </div>
        </div>
        <!-- ./col -->
        <div class="col-lg-3 col-xs-6">
            <!-- small box -->
            <div class="small-box bg-green">
                <div class="inner">
                    <span><font style="font-size: 40px"><?=$month_consume_count?></font>笔</span>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <span><font style="font-size: 40px"><?=$month_money?></font>元</span>

                    <p>本月订单</p>
                </div>
                <div class="icon">
                    <i class="ion ion-stats-bars"></i>
                </div>
                <a href="?r=order/index" class="small-box-footer">查看更多 <i class="fa fa-arrow-circle-right"></i></a>
            </div>
        </div>
        <div class="col-lg-3 col-xs-6">
            <!-- small box -->
            <div class="small-box bg-yellow">
                <div class="inner">
                    <span><font style="font-size: 40px"><?=$total_consume_count?></font>笔</span>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <span><font style="font-size: 40px"><?=$total_money?></font>元</span>

                    <p>总订单</p>
                </div>
                <div class="icon">
                    <i class="ion ion-ios-pie-outline"></i>
                </div>
                <a href="?r=order/index" class="small-box-footer">查看更多 <i class="fa fa-arrow-circle-right"></i></a>
            </div>
        </div>
    </div>
    <!-- /.row -->
</section>
<!-- /.content -->
