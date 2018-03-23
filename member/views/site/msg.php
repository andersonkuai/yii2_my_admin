<section class="content">
    <div class="row">
        <div class="col-xs-4"></div>

        <div class="col-xs-4">
            <div class="small-box bg-light-blue" style="margin-top: 50%">
                <div class="inner">
                    <h3 style="font-size: 20px">提示信息</h3>

                    <p style="padding-top: 20px"><?=$msg;?></p>
                </div>
                <div class="icon">
                    <i class="ion ion-information-circled"></i>
                </div>
                <a href="<?=Yii::$app->getRequest()->getReferrer()?>" class="small-box-footer">
                    返回 <i class="fa fa-arrow-circle-left"></i>
                </a>
            </div>
        </div>
        <div class="col-xs-4"></div>
    </div>
</section>