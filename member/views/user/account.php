<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>
        账户信息
        <small></small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="?r=admin/index"><i class="fa fa-dashboard"></i> 主页</a></li>
        <li><a href="#">个人中心</a></li>
        <li class="active">账户信息</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class="col-xs-12">
            <div class="box">
                <div class="box-header">
                    <h3 class="box-title">账户信息</h3>
                    <div class="box-tools">
                        <div class="input-group input-group-sm" style="width: 150px;">
                            <input type="text" name="table_search" class="form-control pull-right" placeholder="Search">

                            <div class="input-group-btn">
                                <button type="submit" class="btn btn-default"><i class="fa fa-search"></i></button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.box-header -->
                <div class="box-body table-responsive no-padding">
                    <table class="table table-hover">
                        <tr>
                            <th width="10%">库存积分</th>
                            <td width="20%"><strong><i class="fa fa-database text-green"></i> <?=$user['stockpoint']?></strong></td>
                            <td width="20%">
                                <a href="?r=point/stock" type="button" class="btn btn-success btn-sm">明细</a>
                                <a href="?r=recharge/index" type="button" class="btn btn-success btn-sm">充值</a>

                            </td>
                            <td></td>
                        </tr>
                        <tr>
                            <th>红积分</th>
                            <td><strong class=""><i class="fa fa-database text-red"></i> <?=$user['redpoint']?></strong></td>
                            <td>
                                <a href="?r=point/red" type="button" class="btn btn-success btn-sm">明细</a>
                                <a href="?r=point/exchange-red-stock" type="button" class="btn btn-success btn-sm">兑换</a>
                                <a href="#" type="button" class="btn btn-success btn-sm">提现</a>
                            </td>
                            <td></td>
                        </tr>
                        <tr>
                            <th>白积分</th>
                            <td><strong class=""><i class="fa fa-database text-yellow"></i> <?=$user['whitepoint']?></strong></td>
                            <td>
                                <a href="?r=point/white" type="button" class="btn btn-success btn-sm">明细</a>
                            </td>
                            <td></td>
                        </tr>

                    </table>
                </div>
                <!-- /.box-body -->
            </div>
            <!-- /.box -->
        </div>
    </div>
</section>
<!-- /.content -->