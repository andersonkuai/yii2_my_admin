<?php
namespace backend\controllers;

use common\helpers\Func;
use common\models\GlobalStatistics;
use common\models\User;
use Yii;

class AdminController extends BaseController
{

    public function actionIndex(){

        $whitepointCount = User::find()->sum('whitepoint');
        $redpointCount = User::find()->sum('redpoint');
        $stockpointCount = User::find()->sum('stockpoint');

        $renderData['consume_count'] = 1;
        $renderData['money'] = !empty($money)?$money:0;
        $renderData['activated_count'] = 666;
        $renderData['statistics'] = 1;
        $renderData['consume_count'] = 2;
        $renderData['return_config'] = Func::params('return_config');
        $renderData['entrust'] = 1;
        $renderData['other'] = 2;
        $renderData['whitepointCount'] = $whitepointCount;
        $renderData['redpointCount']   = $redpointCount;
        $renderData['stockpointCount'] = $stockpointCount;
        $renderData['userCount'] = 3;
        $renderData['userId'] = Yii::$app->user->getIdentity()->getId() !== null ? Yii::$app->user->getIdentity()->getId():0;
        return $this->display('index', $renderData);
    }

}