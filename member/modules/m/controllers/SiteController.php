<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/10/20
 * Time: 17:41
 */

namespace member\modules\m\controllers;

use yii\helpers\Url;
use yii\web\Controller;

class SiteController extends Controller
{
    public $layout = false;
    public function actionLogin(){
        $from = Url::previous();
        return \Yii::$app->response->redirect('http://www.yunlianmeigou.com/fund/login?from='.urlencode($from));
    }

    public function actionTest(){

        return $this->render('test');
    }
}