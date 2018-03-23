<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model common\models\User */
/* @var $form ActiveForm */
?>
<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>
        设置密码
        <small></small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> 主页</a></li>
        <li><a href="#">个人中心</a></li>
        <li class="active">设置密码</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">

    <div class="row">
        <div class="col-xs-12">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">设置密码</h3>
                </div>
                <!-- /.box-header -->
                <!-- form start -->
                <?php $form = ActiveForm::begin(['id' => 'myForm']); ?>
                <div class="box-body">
                    <div class="row">
                        <div class="col-xs-4">
                            <div class="form-group">
                                <label>旧密码</label>
                                <input class="form-control" name="oldpassword" placeholder="旧密码" type="password"/>
                            </div>
                            <div class="form-group">
                                <label>新密码</label>
                                <input class="form-control" name="newpassword" placeholder="新密码" type="password"/>
                            </div>
                            <div class="form-group">
                                <label>重复新密码</label>
                                <input class="form-control" name="repassword" placeholder="重复新密码" type="password"/>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.box-body -->

                <div class="box-footer">
                    <button type="submit" class="btn btn-primary">提交</button>
                </div>
                <?php ActiveForm::end(); ?>
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
