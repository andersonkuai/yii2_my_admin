<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>
        <?php echo $title;?>
        <small></small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="?r=admin/index"><i class="fa fa-dashboard"></i> 主页</a></li>
        <li><a href="#">订单管理</a></li>
        <li class="active"><?php echo $title;?></li>
    </ol>
</section>
<style>
    .form-group {
        display: inline-block;
        margin-bottom: 0;
        vertical-align: middle;
    }
</style>
<!-- Main content -->
<section class="content">
    <div class="row">
        <div class="col-xs-12">
            <div class="box">
                <form role="form" id="myForm" action="" method="get" action="index">
                    <input type="hidden" name="r" value="order/index">
                    <input name="<?= Yii::$app->request->csrfParam;?>" type="hidden" value="<?= Yii::$app->request->getCsrfToken();?>">
                <div class="box-header">
                    <div class="form-group">
                        <select class="form-control input-sm" name="pay_status"
                                id="pay_status">
                            <option value="">付款状态</option>
                            <option value="0" <?php echo ($vars['pay_status'] == 0 && $vars['pay_status'] !== '' && $vars['pay_status'] !== NULL) ? 'selected' : '' ?>>
                                未付款
                            </option>
                            <option value="1" <?php echo $vars['pay_status'] == 1 ? 'selected' : '' ?>>已付款</option>
                            <option value="2" <?php echo $vars['pay_status'] == 2 ? 'selected' : '' ?>>申请退款</option>
                            <option value="3" <?php echo $vars['pay_status'] == 3 ? 'selected' : '' ?>>退款中</option>
                            <option value="4" <?php echo $vars['pay_status'] == 4 ? 'selected' : '' ?>>已退款</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <select class="form-control input-sm" name="goods_status"
                                id="goods_status">
                            <option value="">发货状态</option>
                            <option value="0" <?php echo ($vars['goods_status'] == 0 && $vars['goods_status'] !== '' && $vars['goods_status'] !== NULL) ? 'selected' : '' ?>>
                                未发货
                            </option>
                            <option value="1" <?php echo $vars['goods_status'] == 1 ? 'selected' : '' ?>>已发货</option>
                            <option value="2" <?php echo $vars['goods_status'] == 2 ? 'selected' : '' ?>>已收货</option>
                            <option value="3" <?php echo $vars['goods_status'] == 3 ? 'selected' : '' ?>>配货中</option>
                        </select>
                    </div>
                    <div class="form-group">
                         <select class="form-control input-sm" name="status"
                                                id="status">
                            <option value="">订单状态</option>
                            <option value="0" <?php echo ($vars['status'] == 0 && $vars['status'] !== '' && $vars['status'] !== NULL) ? 'selected' : '' ?>>
                                未处理
                            </option>
                            <option value="1" <?php echo $vars['status'] == 1 ? 'selected' : '' ?>>已作废</option>
                            <option value="2" <?php echo $vars['status'] == 2 ? 'selected' : '' ?>>待退货</option>
                            <option value="3" <?php echo $vars['status'] == 3 ? 'selected' : '' ?>>已退货</option>
                            <option value="4" <?php echo $vars['status'] == 4 ? 'selected' : '' ?>>订单异常</option>
                            <option value="10" <?php echo $vars['status'] == 10 ? 'selected' : '' ?>>已处理</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <input type="text" id="starttime" name="starttime"
                               value="<?php echo $vars['starttime']; ?>"
                               class=" input-sm" style="width: 90px;"
                               onFocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
                        &nbsp;至&nbsp;
                        <input type="text" id="endtime" name="endtime"
                               value="<?php echo $vars['endtime']; ?>"
                               class=" input-sm" style="width: 90px;"
                               onFocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control input-sm" name="order_sn"
                               placeholder="订单号" style="width: 120px;"
                               value="<?php echo isset($vars['order_sn']) ? $vars['order_sn'] : ''; ?>">
                    </div>

                    <div class="form-group">
                        <input type="text" class="form-control input-sm" name="g_id"
                               placeholder="商品id" style="width: 90px;"
                               value="<?php echo isset($vars['g_id']) ? $vars['g_id'] : ''; ?>">
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control input-sm" name="goods_name"
                               placeholder="商品名字" style="width: 200px;"
                               value="<?php echo isset($vars['goods_name']) ? $vars['goods_name'] : ''; ?>">
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control input-sm" name="uid"
                               placeholder="用户ID" style="width: 75px;"
                               value="<?php echo isset($vars['uid']) ? $vars['uid'] : ''; ?>">
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control input-sm" name="name"
                               placeholder="用户名" style="width: 90px;"
                               value="<?php echo isset($vars['name']) ? $vars['name'] : ''; ?>">
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control input-sm" name="nickname"
                               placeholder="用户昵称" style="width: 90px;"
                               value="<?php echo isset($vars['nickname']) ? $vars['nickname'] : ''; ?>">
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control input-sm" name="shipname"
                               placeholder="收货人" style="width: 90px;"
                               value="<?php echo isset($vars['shipname']) ? $vars['shipname'] : ''; ?>">
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control input-sm" name="tel"
                               placeholder="手机号" style="width: 95px;"
                               value="<?php echo isset($vars['tel']) ? $vars['tel'] : ''; ?>">
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control input-sm" name="deliver_no"
                               placeholder="快递单号" style="width: 90px;"
                               value="<?php echo isset($vars['deliver_no']) ? $vars['deliver_no'] : ''; ?>">
                    </div>

                    <select name="orderby" class=" form-group input-sm" id="orderby">
                        <option value="addtime DESC" <?php echo $vars['orderby'] == 'addtime DESC' ? ' selected' : ''; ?>>
                            购买时间倒序
                        </option>
                        <option value="addtime ASC" <?php echo $vars['orderby'] == 'addtime ASC' ? ' selected' : ''; ?>>购买时间顺序
                        </option>
                    </select>
                    <button type="submit" class="btn form-group btn-info btn-sm">
                        <i class="fa fa-arrow-circle-o-right"></i> 提交
                    </button>
                </div>
                </form>
                <!-- /.box-header -->
                <div class="box-body table-responsive no-padding">
                    <table class="table table-hover">
                        <tr>
                            <th>订单号</th>
                            <th>金额</th>
                            <th>用户</th>
                            <th>收货人</th>
                            <th>商品</th>
                            <th>商品id</th>
                            <th>商品规格</th>
                            <th>数量</th>
                            <th>付款</th>
                            <th>货物</th>
                            <th>订单状态</th>
                            <th>下单时间</th>
                            <th>付款时间</th>
                            <th>退款时间</th>
                            <th>商户id</th>
                        </tr>

                        <?php foreach($list as $row){?>
                            <tr>
                                <td><?php echo $row->order_sn?></td>
                                <td><?php echo $row->money?></td>
                                <td><?php echo $row->name?></td>
                                <td><?php echo $row->shipname?></td>
                                <td>
                                    <small>
                                        <?php if(!empty($row->img)) { ?>
                                            <img src="<?php echo $row->img; ?>" alt="" height="40" />
                                        <?php } ?><br>
                                        <?php echo $row->goods_name; ?>
                                    </small>
                                </td>
                                <td><?php echo $row->g_id;?></td>
                                <td><?php echo $row->spec_des?></td>
                                <td><?php echo $row->quantity?></td>
                                <td>
                                    <small><font color="<?php echo $row->pay_status == 1 ? 'green' : 'red' ?>"><?php echo \common\helpers\Func::param('pay_status', $row->pay_status)?></font></small>
                                </td>
                                <td>
                                    <small><font color="<?php echo $row->goods_status == 1 ? 'green' : 'red' ?>"><?php echo \common\helpers\Func::param('goods_status', $row->goods_status)?></font></small>
                                </td>
                                <td>
                                    <small><font color="<?php echo $row->status == 10 ? 'green' : 'red' ?>"><?php echo \common\helpers\Func::param('status', $row->status)?></font></small>
                                </td>
                                <td><small><?php echo date('Y-m-d H:i:s', $row->addtime); ?></small></td>
                                <td><small><?php echo $row->paytime; ?></small></td>
                                <td>
                                    <small>
                                        <?php
                                            if($row->pay_status == 4){
                                                echo !empty($row->updatetime) ? date('Y-m-d H:i:s', $row->updatetime) : "";
                                            }
                                        ?>
                                    </small>
                                </td>
                                <td><small><?php echo $row->seller_id ?></small></td>
                            </tr>
                        <?php }?>
                    </table>
                </div>
                <!-- /.box-body -->
                <?php if(!empty($pageHtml)):?>
                    <div class="box-footer clearfix">
                        <?php echo $pageHtml ?>
                    </div>
                <?php endif;?>
            </div>
            <!-- /.box -->
        </div>
    </div>
</section>
<!-- /.content -->