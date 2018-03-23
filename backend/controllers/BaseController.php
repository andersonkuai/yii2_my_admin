<?php
namespace backend\controllers;

use Yii;
use yii\rest\ActiveController;
use yii\web\Controller;
use yii\web\ForbiddenHttpException;

class BaseController extends Controller
{
    protected $needLogin = true;
    protected $needAuth = true;
    protected $displayLayout = true;
    public $layout = 'admin';
    public $caid;
    public function beforeAction($action)
    {
        if ( $this->needLogin && Yii::$app->user->getIsGuest() ) {
            Yii::$app->user->loginRequired();
            return false;
        }
        $this->initData();
        if(Yii::$app->user->getId() != 1){
            if ( $this->needAuth && !Yii::$app->user->can($this->caid) ) {
                //throw new ForbiddenHttpException('你没有权限！');
                $this->showMsg('你没有权限！');
                return false;
            }
        }
        return parent::beforeAction($action);
    }
    private function initData(){
        $this->view->title = Yii::$app->params['siteName'];
        $this->caid = $this->id . '.' . $this->action->id;
        $this->_initData();
    }
    protected function _initData(){}
    public function display($view, $params = []){

        if(Yii::$app->getRequest()->getIsPjax())
            $this->displayLayout = false;

        if( $this->displayLayout ){
            return $this->render($view, $params);
        }else{
            return $this->renderPartial($view, $params);
        }
    }
    public function exitJSON( $code, $msg = '' , $data = null){

        exit(json_encode( ['code' => $code, 'msg' => $msg, 'data' => $data] ));
    }
    public function showMsg( $msg ){
        $rtn = $this->display('//site/msg', ['msg' => $msg]);
        exit($rtn);
    }
    protected function searchForm(&$query, $allowKeys ){
//        $searchData = $whereData = [];
        $whereData = '1=1 ';
        foreach( $allowKeys as $key ){
            $keys = explode('.',$key);

            if(!empty($keys[1])){
                $value = Yii::$app->getRequest()->get($keys[1]);
                $searchData[$keys[1]] = $value;
                if( isset($value) && $value != ''){
                    $whereData .= " and {$keys[0]}.{$keys[1]} = '{$value}'";
                }
            }else{
                $value = Yii::$app->getRequest()->get($keys[0]);
                $searchData[$keys[0]] = $value;
                if( isset($value) && $value != ''){
                    $whereData .= " and {$keys[0]} = '{$value}'";
                }
            }
        }
//        return $whereData;
        if(!empty($whereData)) $query->andWhere($whereData);
        return $searchData;
    }
}