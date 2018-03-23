<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>
        子节点管理
        <small>当前节点 <font color="red"><?php echo $row['description'];?></font></small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="?r=admin/index"><i class="fa fa-dashboard"></i> 主页</a></li>
        <li><a href="#">权限管理</a></li>
        <li class="active">节点管理</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class="col-xs-12">
            <form action="" method="post" id="myForm">
                <div class="box">
                    <div class="box-header">
                        <div class="btn-group btn-group-sm" role="group">
                            <a class="btn btn-default" href="<?php echo Yii::$app->getRequest()->getReferrer();?>"><i class="fa fa-arrow-circle-o-left"></i> 返回</a>
                        </div>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <div class="row">
                            <?php foreach($items as $item){?>
                            <div class="col-xs-12">
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="children[]" value="<?php echo $item['name'];?>"
                                            <?php echo in_array($item['name'], $children) ? 'checked="checked"':''?>>
                                        <font color="<?php echo $item['type']==1?"red":"green"?>">[<?php echo $item['type']==1?"角色":"权限"?>]</font>
                                        <?php echo $item['description'];?>
                                    </label>
                                    <a href="?r=auth/parent-child&name=<?php echo $item['name']?>">详细</a>
                                </div>
                            </div>
                            <?php }?>
                        </div>
                    </div>
                    <!-- /.box-body -->
                    <div class="box-footer">
                        <input type="hidden" name="name" value="<?php echo $row['name']?>"/>
                        <input name="<?= Yii::$app->request->csrfParam;?>" type="hidden" value="<?= Yii::$app->request->getCsrfToken();?>">
                        <button type="submit" class="btn btn-primary">提交</button>
                    </div>
                </div>
                <!-- /.box -->
            </form>
        </div>
    </div>
</section>
<!-- /.content -->
<script type="text/javascript">
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