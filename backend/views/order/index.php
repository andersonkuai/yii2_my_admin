<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>
        <?= \Yii::t('app', '订单列表');?>
        <small></small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="?r=admin/index"><i class="fa fa-dashboard"></i> <?= \Yii::t('app', '主页');?></a></li>
        <li><a href="#"><?= \Yii::t('app', '订单管理');?></a></li>
        <li class="active"><?= \Yii::t('app', '订单列表');?></li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class="col-xs-12">
            <div class="box">
                <div class="box-header">
                    <div class="btn-group btn-group-sm" role="group">
<!--                        <a class="btn btn-primary" href="?r=user/add"><i class="fa fa-plus"></i> 添加</a>-->
                    </div>
                    <div class="box-tools">
                        <form action="" method="get" class="form-inline">
                            <input type="hidden" name="r" value="order/index">
                            <div class="form-group form-group-sm">
                                <input type="text" name="Uid" class="form-control" placeholder="<?= \Yii::t('app', '用户ID');?>"
                                       value="<?=!empty($searchData['Uid'])?$searchData['Uid']:''?>">
                            </div>
                            <div class="form-group form-group-sm">
                                <input type="text" name="UserName" class="form-control" placeholder="<?= \Yii::t('app', '用户名');?>"
                                       value="<?=!empty($searchData['UserName'])?$searchData['UserName']:''?>">
                            </div>
                            <div class="form-group form-group-sm">
                                <input type="text" name="Mobile" class="form-control" placeholder="<?= \Yii::t('app', '手机号');?>"
                                       value="<?=!empty($searchData['Mobile'])?$searchData['Mobile']:''?>">
                            </div>
                            <div class="form-group form-group-sm">
                                <input type="text" name="ProdName" class="form-control" placeholder="<?= \Yii::t('app', '课程名称');?>"
                                       value="<?=!empty($searchData['ProdName'])?$searchData['ProdName']:''?>">
                            </div>
                            <div class="form-group form-group-sm">
                                <select class="form-control" name="PayType" id="">
                                    <option value="" ><?= \Yii::t('app', '支付方式');?></option>
                                    <?php
                                        foreach (\common\enums\Order::pfvalues('PAY_TYPE') as $key => $obj){
                                            $selected = isset($searchData['PayType']) && $searchData['PayType'] == $obj->getValue()
                                                ? 'selected="selected"':'';
                                            echo '<option '.$selected.' value="'.$obj->getValue().'">'.\common\enums\Order::labels()[$key].'</option>';
                                        }
                                    ?>
                                </select>
                            </div>
                            <div class="form-group form-group-sm">
                                <select class="form-control" name="Status" id="">
                                    <option value="" ><?= \Yii::t('app', '订单状态');?></option>
                                    <?php
                                    foreach (\common\enums\Order::pfvalues('STATUS') as $key => $obj){
                                        $selected = isset($searchData['Status']) && $searchData['Status'] == $obj->getValue()
                                            ? 'selected="selected"':'';
                                        echo '<option '.$selected.' value="'.$obj->getValue().'">'.\common\enums\Order::labels()[$key].'</option>';
                                    }
                                    ?>
                                </select>
                            </div>
                            <div class="form-group form-group-sm">
                                <select class="form-control" name="SendStatus" id="">
                                    <option value="" ><?= \Yii::t('app', '发货状态');?></option>
                                    <?php
                                    foreach (\common\enums\Order::pfvalues('SEND') as $key => $obj){
                                        $selected = isset($searchData['SendStatus']) && $searchData['SendStatus'] == $obj->getValue()
                                            ? 'selected="selected"':'';
                                        echo '<option '.$selected.' value="'.$obj->getValue().'">'.\common\enums\Order::labels()[$key].'</option>';
                                    }
                                    ?>
                                </select>
                            </div>
                            <div class="form-group form-group-sm">
                                <input type="text" name="Time1" class="form-control" placeholder="<?= \Yii::t('app', '下单时间');?>"
                                       value="<?=!empty($searchData['Time1'])?$searchData['Time1']:''?>" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
                                --
                                <input type="text" name="Time2" class="form-control" placeholder="<?= \Yii::t('app', '下单时间');?>"
                                       value="<?=!empty($searchData['Time2'])?$searchData['Time2']:''?>" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
                            </div>
                            <button type="submit" class="btn btn-primary btn-sm"><?= \Yii::t('app', '搜索');?></button>
                        </form>

                    </div>
                </div>
                <!-- /.box-header -->
                <div class="box-body table-responsive no-padding">
                    <table class="table table-hover">
                        <tr>
                            <th style="text-align: center"><input type="checkbox" onclick="UTILITY.CHECK.all(this);"/></th>
                            <th><?= \Yii::t('app', '订单号');?></th>
                            <th><?= \Yii::t('app', '用户ID');?></th>
                            <th><?= \Yii::t('app', '用户名');?></th>
<!--                            <th>--><?//= \Yii::t('app', '第三方交易号');?><!--</th>-->
                            <th><?= \Yii::t('app', '订单价格');?></th>
                            <th><?= \Yii::t('app', '支付金额');?></th>
                            <th><?= \Yii::t('app', '抵扣金额');?></th>
                            <th><?= \Yii::t('app', '课程名称');?></th>
                            <th><?= \Yii::t('app', '联系人');?></th>
                            <th><?= \Yii::t('app', '收货地址');?></th>
                            <th><?= \Yii::t('app', '城市');?></th>
                            <th><?= \Yii::t('app', '支付方式');?></th>
                            <th><?= \Yii::t('app', '订单状态');?></th>
                            <th><?= \Yii::t('app', '发货状态');?></th>
                            <th><?= \Yii::t('app', '订单生成时间');?></th>
                            <th><?= \Yii::t('app', '支付时间');?></th>
<!--                            <th>--><?//= \Yii::t('app', '操作');?><!--</th>-->
                        </tr>

                        <?php foreach($orders as $val){?>
                            <tr>
                                <td align="center"><input type="checkbox" name="checkids[]" value="<?php echo $val['OrderId'];?>"/></td>
                                <td><?php echo $val['OrderId']?></td>
                                <td><?php echo $val['Uid']?></td>
                                <td><?php echo $val['UserName']?></td>
<!--                                <td>--><?php //echo $val['Trade']?><!--</td>-->
                                <td><?php echo $val['Price']?></td>
                                <td><?php echo $val['DiscountPrice']?></td>
                                <td><?php echo $val['Price'] - $val['DiscountPrice']?></td>
                                <td><?php echo $val['ProdName']?></td>
                                <td><?php echo $val['Mobile']?></td>
                                <td><?php echo $val['Province'].$val['City'].$val['Area'].$val['Address']?></td>
                                <td><?php echo $val['City']?></td>
                                <td><?php echo \common\enums\Order::labels()[\common\enums\Order::pfwvalues('PAY_TYPE')[$val['PayType']]]?></td>
                                <td><?php $status = \common\enums\Order::labels()[\common\enums\Order::pfwvalues('STATUS')[$val['Status']]];if($val['Status'] == 1){
                                echo '<span style="color: green">'.$status.'</span>';
                                }else{
                                echo '<span style="color: red">'.$status.'</span>';
                                }?></td>
                                <td><?php $send = \common\enums\Order::labels()[\common\enums\Order::pfwvalues('SEND')[$val['SendStatus']]];if($val['SendStatus'] == 1){
                                echo '<span style="color: green">'.$send.'</span>';
                                }else{
                                echo '<span style="color: red">'.$send.'</span>';
                                }?></td>
                                <td><?php echo date("Y-m-d H:i:s", $val['Time'])?></td>
                                <td><?php if(!empty($val['PayTime'])) echo date("Y-m-d H:i:s", $val['PayTime'])?></td>
<!--                                <td></td>-->
                            </tr>
                        <?php }?>
                    </table>
                </div>
                <!-- /.box-body -->
                <div class="box-footer clearfix">
<!--                    <div class="btn-group btn-group-sm" role="group">-->
<!--                        <button class="btn btn-default" onclick="UTILITY.CHECK.post('?r=user/status&status=0', '确定禁用？');">禁用</button>-->
<!--                        <button class="btn btn-default" onclick="UTILITY.CHECK.post('?r=user/status&status=10', '确定解禁？');">解禁</button>-->
<!--                    </div>-->
                    <?php echo $pageHtml;?>
                </div>
            </div>
            <!-- /.box -->
        </div>
    </div>
</section>
<!-- /.content -->