<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/9/18
 * Time: 11:29
 */

namespace member\controllers;

use common\classes\DelayTask;
use common\classes\SystemOperate;
use yii\web\Controller;
class TestController extends Controller
{
    public function actionQueue(){

        //$r = DelayTask::instance()->put('TEST', ['a' => 4, 'b'=>25]);

        //var_dump($r);


        $r = DelayTask::instance()->getQueue()->stats();

        print_r($r);
    }

    public function actionTest(){


        list($code, $msg) = SystemOperate::cancelConsume('cs59f9885167d5c3113', 20000.00);

        var_dump($msg);
    }

    public function actionTest2(){

        $rtn = DelayTask::instance()->putToQueue('NOTICE_CONSUME_COMMISSION', 'cs5a051226ce7f78529');

        print_r($rtn);
    }
}