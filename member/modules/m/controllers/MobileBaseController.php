<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/10/20
 * Time: 14:33
 */

namespace member\modules\m\controllers;

use member\controllers\BaseController;
use yii\helpers\Url;
use yii\web\Controller;
use Yii;

class MobileBaseController extends BaseController
{
    public $layout = 'member-m';

    public function beforeAction($action)
    {
        $accessToken = strval(Yii::$app->request->get('accesstoken'));
        if ( $this->needLogin &&
            (
                //Yii::$app->user->getIsGuest() &&
                !( empty($accessToken) ? Yii::$app->user->getIdentity() : Yii::$app->user->loginByAccessToken($accessToken) )
            ) ) {

            Url::remember();
            Yii::$app->user->loginRequired();
            return false;
        }
        $this->initData();

        return Controller::beforeAction($action);
    }
}