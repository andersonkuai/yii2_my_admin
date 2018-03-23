<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>
        <?php echo empty($row) ? '添加':'编辑'?>下级代理商
        <small></small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="?r=admin/index"><i class="fa fa-dashboard"></i> 主页</a></li>
        <li><a href="#">权限管理</a></li>
        <li class="active"><?php echo empty($row) ? '添加':'编辑'?>用户</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">

    <div class="row">
        <div class="col-xs-12">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <div class="btn-group btn-group-sm" role="group">
                        <a class="btn btn-default" href="?r=user/index"><i class="fa fa-arrow-circle-o-left"></i> 返回</a>
                    </div>
                </div>
                <!-- /.box-header -->
                <!-- form start -->
                <form role="form" id="myForm" action="" method="post">
                    <div class="box-body">
                        <div class="row">
                            <div class="col-xs-6">
                                <div class="row">
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label>用户名</label>
                                            <input <?php echo !empty($row)?'disabled="disabled"':''?> class="form-control" name="username" placeholder="用户名" type="text" value="<?php echo empty($row) ? '' : $row['username'];?>">
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label>密码</label>
                                            <input class="form-control" name="password" placeholder="密码" type="text" value="">
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label>手机</label>
                                            <input class="form-control" name="mobile" placeholder="手机" type="text" value="<?php echo empty($row) ? '' : $row['mobile'];?>">
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label>邮箱</label>
                                            <input class="form-control" name="email" placeholder="邮箱" type="text" value="<?php echo empty($row) ? '' : $row['email'];?>">
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label>真实姓名</label>
                                            <input class="form-control" name="realname" placeholder="真实姓名" type="text" value="<?php echo empty($row) ? '' : $row['realname'];?>">
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label>身份证号</label>
                                            <input class="form-control" name="idnumber" placeholder="身份证号" type="text" value="<?php echo empty($row) ? '' : $row['idnumber'];?>">
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label>头像</label>
                                            <div class="input-group">
                                                <input class="form-control" name="avatar" placeholder="头像" type="text" value="<?php echo empty($row) ? '' : $row['avatar'];?>">
                                                <span class="input-group-btn">
                                                  <button type="button" class="btn btn-info uploadBtn">选择</button>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xs-6">
                                <table class="table">
                                    <tr>
                                        <td>最后登陆时间</td>
                                        <td><?php echo empty($row['lastlogin_time']) ? '' : date('Y-m-d H:i:s', $row['lastlogin_time']);?></td>
                                    </tr>
                                    <tr>
                                        <td>最后登陆IP</td>
                                        <td><?php echo empty($row) ? '' : $row['lastlogin_ip'];?></td>
                                    </tr>
                                    <tr>
                                        <td>创建时间</td>
                                        <td><?php echo empty($row) ? '' : date('Y-m-d H:i:s', $row['created']);?></td>
                                    </tr>
                                    <tr>
                                        <td>激活时间</td>
                                        <td>
                                            <?php if(!empty($row)) { if($row['is_activated'] == 1) { ?>
                                                <?php echo empty($row) ? '' : date('Y-m-d H:i:s', $row['activated_time']);?>
                                            <?php }else{ ?>
                                                <span>未激活</span>
                                            <?php }} ?>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            编辑时间
                                        </td>
                                        <td>
                                            <?php echo empty($row) ? '' : date('Y-m-d H:i:s', $row['modified']);?>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            状态
                                        </td>
                                        <td>
                                            <span class="label label-danger"><?php echo empty($row) ? '' : Yii::$app->params['user.status'][$row['status']];?></span>
                                        </td>
                                    </tr>

                                </table>

                            </div>
                        </div>
                    </div>
                    <!-- /.box-body -->

                    <div class="box-footer">
                        <?php if(!empty($row)){?>
                            <input type="hidden" name="id" value="<?php echo $row['id']?>"/>
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

        UTILITY.UPLOAD.bind('.uploadBtn');
    });
    -->
</script>