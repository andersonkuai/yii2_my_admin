<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>
        我推荐的会员
        <small></small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="?r=admin/index"><i class="fa fa-dashboard"></i> 主页</a></li>
        <li><a href="#">个人中心</a></li>
        <li class="active">我的推荐</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class="col-xs-12">
            <div class="box">
                <div class="box-header">
                    <h3 class="box-title">我推荐的会员</h3>
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
                            <th>ID</th>
                            <th>昵称</th>
                            <th>注册时间</th>
                        </tr>
                        <?php if(!empty($recommenders)){
                            foreach($recommenders as $recommender){
                            ?>
                        <tr>
                            <td><?=$recommender['id']?></td>
                            <td><?=$recommender['nickname']?></td>
                            <td><?=date('Y-m-d H:i:s', $recommender['created'])?></td>
                        </tr>
                        <?php }}else{?>
                        <tr><td colspan="3">暂无记录！</td></tr>
                        <?php }?>
                    </table>
                </div>
                <!-- /.box-body -->
            </div>
            <!-- /.box -->
        </div>
    </div>
</section>
<!-- /.content -->