<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>
        <?= \Yii::t('app', '角色列表');?>
        <small></small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="?r=admin/index"><i class="fa fa-dashboard"></i> <?= \Yii::t('app', '主页');?></a></li>
        <li><a href="#"><?= \Yii::t('app', '权限管理');?></a></li>
        <li class="active"><?= \Yii::t('app', '角色列表');?></li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class="col-xs-12">
            <div class="box">
                <div class="box-header">
                    <button type="button" class="btn btn-primary btn-sm"
                            data-toggle="modal" data-target="#exampleModal" data-whatever=''>
                        <i class="fa fa-plus"></i> <?= \Yii::t('app', '添加');?></button>
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
                            <th style="text-align: center"><input type="checkbox" onclick="UTILITY.CHECK.all(this);"/></th>
                            <th><?= \Yii::t('app', '名称');?></th>
                            <th><?= \Yii::t('app', '描述');?></th>
                            <th><?= \Yii::t('app', '添加');?></th>
                            <th><?= \Yii::t('app', '操作');?></th>
                        </tr>

                        <?php foreach($roles as $row){?>
                            <tr>
                                <td align="center"><input type="checkbox" name="checkids[]" value="<?php echo $row['name'];?>"/></td>
                                <td><?php echo $row['name'];?></td>
                                <td><?php echo $row['description'];?></td>
                                <td><?php echo date("Y-m-d", $row['created_at'])?></td>
                                <td>
                                    <div class="btn-group btn-group-sm" role="group">
                                        <button class="btn btn-default"
                                                data-toggle="modal" data-target="#exampleModal" data-whatever='<?php echo json_encode($row)?>'>
                                            <i class="fa fa-edit"></i> <?= \Yii::t('app', '编辑');?></button>
                                        <a class="btn btn-default" href="?r=auth/parent-child&name=<?php echo $row['name'];?>"><i class="fa fa-code-fork"></i><?= \Yii::t('app', '权限');?></a>
                                    </div>
                                </td>
                            </tr>
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
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form action="?r=auth/item-save" method="post" id="myForm">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="exampleModalLabel">添加角色</h4>
                </div>
                <div class="modal-body">

                    <div class="form-group">
                        <label for="recipient-name" class="control-label">角色标识:</label>
                        <input type="text" class="form-control" name="name">
                        <p class="help-block">示例：role-admin，建议使用“role-”为前缀作为角色标识</p>
                    </div>
                    <div class="form-group">
                        <label for="message-text" class="control-label">角色描述:</label>
                        <textarea class="form-control" name="description"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <input type="hidden" name="key" value="">
                    <input type="hidden" name="type" value="1">
                    <input name="<?= Yii::$app->request->csrfParam;?>" type="hidden" value="<?= Yii::$app->request->getCsrfToken();?>">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="submit" class="btn btn-primary">添加</button>
                </div>
            </form>
        </div>
    </div>
</div>
<script type="text/javascript">
    $('#exampleModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var recipient = button.data('whatever');
        var modal = $(this);
        modal.find('.modal-footer input[name=key]').val('');
        modal.find('.modal-body input[name=name]').val('');
        modal.find('.modal-body textarea').val('');

        if( recipient != '' ){
            modal.find('.modal-footer input[name=key]').val(recipient.name);
            modal.find('.modal-body input[name=name]').val(recipient.name);
            modal.find('.modal-body textarea').val(recipient.description);
        }
    });
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
</script>