<?php

namespace member\modules\m;

/**
 * m module definition class
 */
class Module extends \yii\base\Module
{
    /**
     * @inheritdoc
     */
    public $controllerNamespace = 'member\modules\m\controllers';

    /**
     * @inheritdoc
     */
    public function init()
    {
        parent::init();
        //http://beta-www.yunlianmeigou.com/fund/login
        \Yii::$app->user->loginUrl = ['m/site/login'];
        // custom initialization code goes here
    }
}
