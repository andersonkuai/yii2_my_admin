<!-- Content Header (Page header) -->
<script language="javascript" type="text/javascript"
        src="/97date/WdatePicker.js"></script>
<section class="content-header">
    <h1>
        下级代理商列表
        <small></small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="?r=admin/index"><i class="fa fa-dashboard"></i> 主页</a></li>
        <li><a href="#">下级管理</a></li>
        <li class="active">下级列表</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class="col-xs-12">
            <div class="box">
                <div class="box-header">
                    <div class="btn-group btn-group-sm" role="group">
                        <a class="btn btn-primary" href="?r=user/add"><i class="fa fa-plus"></i> 添加</a>
                    </div>
                    <div class="box-tools">
                        <form action="" method="get" class="form-inline">
                            <input type="hidden" name="r" value="user/index">
                            <div class="form-group form-group-sm">
                                <input type="text" name="id" class="form-control" placeholder="用户ID"
                                       value="<?=!empty($searchData['id'])?$searchData['id']:''?>">
                            </div>
                            <div class="form-group form-group-sm">
                                <input type="text" name="username" class="form-control" placeholder="用户名"
                                       value="<?=!empty($searchData['username'])?$searchData['username']:''?>">
                            </div>
                            <div class="form-group form-group-sm">
                                <select class="form-control" name="is_activated" id="">
                                    <option value="" >是否激活</option>
                                    <option value="1" <?php echo $searchData['is_activated'] == 1 ? 'selected' : ''; ?>>激活</option>
                                    <option value="2" <?php echo $searchData['is_activated'] == 2 ? 'selected' : ''; ?>>未激活</option>
                                </select>
                            </div>
                            <div class="form-group form-group-sm">
                                <input type="text" name="activated_time" class="form-control" placeholder="激活时间"
                                       value="<?=!empty($searchData['activated_time'])?$searchData['activated_time']:''?>" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
                            </div>
                            <button type="submit" class="btn btn-primary btn-sm">确定</button>
                        </form>

                    </div>
                </div>
                <!-- /.box-header -->
                <div class="box-body table-responsive no-padding">
                    <table class="table table-hover">
                        <tr>
                            <th>ID</th>
                            <th>用户名</th>
                            <th>昵称</th>
                            <th>真实姓名</th>
                            <th>手机号</th>
                            <th>省</th>
                            <th>市</th>
                            <th>区县</th>
                            <th>创建时间</th>
                            <th>激活时间</th>
                            <th>最后登陆</th>
                            <th>代理状态</th>
                            <th>账号状态</th>
                            <th>操作</th>
                        </tr>

                        <?php foreach($users as $user){?>
                            <tr>
                                <td><?php echo $user['id']?></td>
                                <td><?php echo $user['username']?></td>
                                <td><?php echo $user['nickname']?></td>
                                <td><?php echo $user['realname']?></td>
                                <td><?php echo $user['mobile']?></td>
                                <td><?php echo $user['province'];?></td>
                                <td><?php echo $user['city'];?></td>
                                <td><?php echo $user['country'];?></td>
                                <td><?php echo date("Y-m-d", $user['created'])?></td>
                                <td><?php if(!empty($user['activated_time'])) echo date("Y-m-d H:i:s", $user['activated_time'])?></td>
                                <td><?php if(!empty($user['lastlogin_time'])) echo date("Y-m-d H:i:s", $user['lastlogin_time'])?></td>
                                <td>
                                    <?php if($user['is_activated'] == 1){ ?>
                                        <span class="label label-success">激活</span>
                                    <?php }else{?>
                                        <span class="label label-default">未激活</span>
                                    <?php }?>
                                </td>
                                <td>
                                    <?php if($user['status'] == 10){ ?>
                                        <span class="label label-success">正常</span>
                                    <?php }else{?>
                                        <span class="label label-danger">禁用</span>
                                    <?php }?>
                                </td>
                                <td>
                                    <div class="btn-group btn-group-sm" role="group">
                                        <?php if($user['is_activated'] != 1) { ?>
                                            <a class="btn btn-default" href="javascript:void(0)" onclick="UTILITY.OPERATE.get('?r=user/activate&id=<?php echo $user['id']?>');"><i class="fa fa-edit"></i> 激活</a>
                                        <?php }else{ ?>
                                            <a style="visibility:hidden" class="btn btn-default" href="javascript:void(0)"><i class="fa fa-edit"></i> 占位</a>
                                        <?php } ?>
                                        <a class="btn btn-default" href="/index.php?r=user/edit&id=<?php echo $user['id']?>"><i class="fa fa-edit"></i> 编辑</a>
                                        <?php if($user['status'] == 10) { ?>
                                            <a class="btn btn-danger" href="javascript:void(0);" onclick="UTILITY.OPERATE.get('?r=user/delete&id=<?php echo $user['id']?>');"><i class="fa fa-trash-o"></i> 禁用</a>
                                        <?php } else { ?>
                                            <a class="btn btn-default" href="javascript:void(0);" onclick="UTILITY.OPERATE.get('?r=user/relieve&id=<?php echo $user['id']?>');"><i class="fa fa-check-circle-o"></i> 解禁</a>
                                        <?php } ?>
                                    </div>
                                </td>
                            </tr>
                        <?php }?>
                    </table>
                </div>
            </div>
            <!-- /.box -->
        </div>
    </div>
</section>
<!-- /.content -->