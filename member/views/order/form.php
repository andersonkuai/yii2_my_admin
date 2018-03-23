<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>
        <?php echo empty($row) ? '添加':'编辑'?>消费
        <small></small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="?r=admin/index"><i class="fa fa-dashboard"></i> 主页</a></li>
        <li><a href="#">消费明细</a></li>
        <li class="active"><?php echo empty($row) ? '添加':'编辑'?>消费</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">

    <div class="row">
        <div class="col-xs-12">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <div class="btn-group btn-group-sm" role="group">
                        <a class="btn btn-default" href="?r=consume/index"><i class="fa fa-arrow-circle-o-left"></i> 返回</a>
                    </div>
                </div>
                <!-- /.box-header -->
                <!-- form start -->
                <form role="form" id="myForm" action="" method="post">
                    <div class="box-body">
                        <div class="row">
                            <div class="col-xs-4">
                                <div class="form-group">
                                    <label>可用库存积分</label>
                                    <div><span class="label label-danger"><?php echo $user['stockpoint'];?></span></div>
                                </div>
                                <div class="form-group">
                                    <label>用户ID</label>
                                    <input class="form-control" name="consume_uid" placeholder="用户ID" type="text" value="<?php echo empty($row) ? '' : $row['consume_uid'];?>">
                                </div>
                                <div class="form-group">
                                    <label>用户预留手机（后4位）</label>
                                    <input class="form-control" name="mobile" placeholder="用户预留手机（后4位）" type="text"/>
                                </div>
                                <div class="form-group">
                                    <label>消费金额（元）</label>
                                    <input class="form-control" name="money" placeholder="消费金额（元）" type="text" value="<?php echo empty($row) ? '' : sprintf('%.2f', $row['money']);?>">
                                </div>
                                <div class="form-group">
                                    <label>平台</label>
                                    <select class="form-control" name="platform">
                                        <?php $platforms = \common\helpers\Func::params('user_consume.platform');?>
                                        <?php foreach($platforms as $platform_id => $platform_name){?>
                                        <option value="<?php echo $platform_id;?>"><?php echo $platform_name?></option>
                                        <?php }?>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label>平台订单号</label>
                                    <div class="input-group">
                                        <input class="form-control" name="order_sn" placeholder="平台订单号"type="text" autocomplete="off" value="<?php echo empty($row) ? '' : $row['order_sn'];?>">
                                        <span class="input-group-btn">
                                          <button type="button" class="btn btn-info" onclick="$('input[name=order_sn]').val(UTILITY.TOOL.uniqid('ts'));">生成</button>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xs-4">
                                <p class="lead text-green">说明：</p>
                                <p class="text-green">1.库存积分必须大于消费金额乘以100。</p>
                                <p class="text-green">2.平台订单号唯一，不能重复。</p>
                            </div>
                        </div>
                    </div>
                    <!-- /.box-body -->

                    <div class="box-footer">
                        <?php if(!empty($row)){?>
                            <input type="hidden" name="consume_sn" value="<?php echo $row['consume_sn']?>"/>
                        <?php }?>
                        <input name="<?= Yii::$app->request->csrfParam;?>" type="hidden" value="<?= Yii::$app->request->getCsrfToken();?>">
                        <button type="submit" class="btn btn-primary">提交</button>
                    </div>
                </form>
            </div>

        </div>
    </div>
</section>
<!-- /.content -->
<script type="text/javascript">
    <!--
    $(document).ready(function() {

        $('#myForm').ajaxForm({
            dataType:"json",
            success:function(data){
                alert(data.msg);
                if(data.code == 1){
                    location.href = location.href ;
                }
            }
        });
    });
    -->
</script>