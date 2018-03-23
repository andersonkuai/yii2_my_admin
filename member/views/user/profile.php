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
        基本资料
        <small></small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="/"><i class="fa fa-dashboard"></i> 主页</a></li>
        <li><a href="#">个人中心</a></li>
        <li class="active">基本资料</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">

    <div class="row">
        <div class="col-xs-12">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">基本资料</h3>
                </div>
                <!-- /.box-header -->
                <!-- form start -->
                <?php $form = ActiveForm::begin(['id' => 'myForm']); ?>
                <div class="box-body">
                    <div class="row">
                        <div class="col-xs-4">
                            <?= $form->field($model, 'username')->input('text', ['disabled' => 'disabled']); ?>
                            <div class="form-group">
                                <label>头像</label>
                                <div class="input-group">
                                    <input class="form-control" name="User[avatar]" placeholder="头像" type="text" value="<?= $model->avatar;?>" readonly>
                                    <span class="input-group-btn">
                                      <button type="button" class="btn btn-info uploadBtn">选择</button>
                                    </span>
                                </div>
                            </div>
                            <?= $form->field($model, 'email') ?>
                            <?= $form->field($model, 'realname') ?>
                            <?= $form->field($model, 'idnumber') ?>

                        </div>
                        <div class="col-xs-4">
                            <table class="table">
                                <tr>

                                    <td>最后登陆时间</td>
                                    <td><?= date("Y-m-d H:i:s", $model->lastlogin_time) ?></td>
                                </tr>
                                <tr>
                                    <td>最后登陆IP</td>
                                    <td><?= $model->lastlogin_ip?></td>
                                </tr>
                                <tr>
                                    <td>创建时间</td>
                                    <td><?= date("Y-m-d H:i:s",$model->created)?></td>
                                </tr>
                                <tr>
                                    <td>编辑时间</td>
                                    <td><?= date("Y-m-d H:i:s", $model->modified);?></td>
                                </tr>
                                <tr>
                                    <td>状态</td>
                                    <td><span class="label label-danger"><?= Yii::$app->params['user.status'][$model->status];?></span></td>
                                </tr>

                            </table>

                        </div>
                        <div class="col-xs-4">
                            <div>
                                <h5>上传头像</h5>
                                <hr/>
                                <div class="imageBox">
                                    <div class="thumbBox"></div>
                                    <div class="spinner" style="">请上传新头像</div>
                                </div>
                                <div class="action">
                                    <div class="btn-group">
                                        <button id="file" type="button" class="btn btn-default btn-sm"><i class="fa fa-file-image-o"></i> 选择</button>
                                        <button id="btnZoomIn" type="button" class="btn btn-default btn-sm"><i class="fa fa-search-plus" aria-hidden="true"></i> 放大</button>
                                        <button id="btnZoomOut" type="button" class="btn btn-default btn-sm"><i class="fa fa-search-minus" aria-hidden="true"></i> 缩小</button>
                                    </div>
                                </div>
                                <hr/>
                                <div class="btn-group">
                                    <input type="file" id="realfile" class="hidden">
                                    <button type="button" class="btn btn-success btn-sm saveCropImage"><i class="fa fa-save"></i> 保存</button>
                                </div>
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
        UTILITY.UPLOAD.bind('.uploadBtn');
    });
    -->
</script>
<script type="text/javascript" src="/js/cropbox.js"></script>
<style type="text/css">
    .imageBox {
        background-color: #fff;
        border: 1px solid #bbb;
        cursor: move;
        height: 200px;
        overflow: hidden;
        position: relative;
        width: 200px;
    }
    .imageBox .thumbBox {
        border: 1px dashed rgb(102, 102, 102);
        box-shadow: 0 0 0 1000px rgba(0, 0, 0, 0.1);
        box-sizing: border-box;
        width: 150px;
        height: 150px;
        left:25px;
        top:25px;
        position: absolute;
    }
    .imageBox .spinner {
        background-color: rgba(0, 0, 0, 0.05);
        bottom: 0;
        top: 0;
        left: 0;
        right:0;
        line-height: 200px;
        position: absolute;
        text-align: center;

    }
    .action{margin-top: 10px;}
</style>
<script type="text/javascript">
    $(document).ready(function() {
        jQuery('#file').on('click touchstart touchend tap taphold', function() {
            jQuery('input#realfile').click();
        });
        var options = {
                thumbBox: '.thumbBox',
                spinner : '.spinner',
                imgSrc : '',
            }
        var cropper = $('.imageBox').cropbox(options);


        $('#realfile').on('change', function () {
            var reader = new FileReader();
            reader.onload = function (e) {
                options.imgSrc = e.target.result;
                cropper = $('.imageBox').cropbox(options);
            }
            reader.readAsDataURL(this.files[0]);
            this.files = [];
        });
       /*$('#btnCrop').on('click', function () {
            var img = cropper.getDataURL();
            $('.cropped').html('<img src="' + img + '">');
        })*/
        $('#btnZoomIn').on('click', function () {
            cropper.zoomIn();
        });
        $('#btnZoomOut').on('click', function () {
            cropper.zoomOut();
        });
        $(".saveCropImage").on('click',function(){

            if(cropper.image.src == window.location.href){
                alert('请先选择头像！');
                return false;
            }
            var img = cropper.getDataURL();
            var postData = [{"name":"base64","value":img}];
            if(typeof CSRF != "undefined"){
                postData.push(CSRF);
            }
            $.post("?r=user/upload-avatar",postData, function(data){
                alert(data.msg);
            },'json');
        });
    });
</script>
