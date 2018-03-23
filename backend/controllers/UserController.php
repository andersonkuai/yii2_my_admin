<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/8/24
 * Time: 9:34
 */

namespace backend\controllers;

use Yii;
use common\models\User;
use yii\data\Pagination;
use yii\widgets\LinkPager;

class UserController extends BaseController
{
    public function actionIndex(){
        $query = User::find()->andWhere(1);
        $searchData = $this->searchForm($query, ['id', 'username', 'ylmguid','is_activated','level','status']);
        //激活时间
        if(!empty($_GET['activated_time'])){
            $searchData['activated_time'] = $_GET['activated_time'];
            if($_GET['is_activated'] == 1){
                $activated_time = strtotime($_GET['activated_time']);
                $query = $query->andWhere("activated_time > '{$activated_time}'");
            }
        }
        $pages = new Pagination(['totalCount' =>$query->count(), 'pageSize' => 10]);
        $users = $query->offset($pages->offset)->limit($pages->limit)->all();
        $renderData = [
            'users' => $users,
            'searchData' => $searchData,
            'pageHtml' => LinkPager::widget([
                'pagination' => $pages,
                'options' => ['class' => 'pagination pagination-sm no-margin pull-right']
            ])
        ];
        return $this->display('index', $renderData);
    }
    public function actionAdd(){

        if(Yii::$app->getRequest()->getIsPost()){
            $this->doForm();
        }else{
            $renderData = [];
            return $this->display('form', $renderData);
        }
    }
    public function actionEdit(){
        if(Yii::$app->getRequest()->getIsPost()){
            $this->doForm();
        }else {
            $id = intval(Yii::$app->getRequest()->get('id'));
            $row = User::findOne(['id' => $id]);
            $renderData = ['row' => $row];
            return $this->display('form', $renderData);
        }
    }

    /**
     * 禁用解禁用户账号
     */
    public function actionStatus(){
        $status = intval( Yii::$app->getRequest()->get('status'));

        $checkids =  Yii::$app->getRequest()->post('checkids');

        $rtn = User::updateAll(['status' => $status], ['id' => $checkids]);

        if( $rtn ){
            $this->exitJSON(1, 'Success!');
        }else{
            $this->exitJSON(0, 'Fail!');
        }
    }

    /**
     * 删除用户账号
     */
    public function actionDelete(){
        $id = intval( Yii::$app->getRequest()->get('id') );

        if( $id ){

            $user = User::findOne( $id );
            $user->updateAttributes(['status' => User::STATUS_DELETED]);
        }
        $this->exitJSON(1, 'Success!');
    }

    /**
     * 激活代理商
     */
    public function actionActivate(){
        $id = intval( Yii::$app->getRequest()->get('id') );

        if( $id ){

            $user = User::findOne( $id );
            $user->updateAttributes(['is_activated' => User::ACTIVATED_YES, 'activated_time' => time()]);
        }
        $this->exitJSON(1, 'Success!');
    }
    private function doForm(){

        $id = intval( Yii::$app->getRequest()->post('id') );
        $username = trim(Yii::$app->getRequest()->post('username'));
        $password = trim(Yii::$app->getRequest()->post('password'));
        $realname = trim(Yii::$app->getRequest()->post('realname'));
        $mobile   = trim(Yii::$app->getRequest()->post('mobile'));
        $level = trim(Yii::$app->getRequest()->post('level'));

        $membertype     = intval(Yii::$app->getRequest()->post('membertype'));
        $email          = trim(Yii::$app->getRequest()->post('email'));
        $idnumber       = trim(Yii::$app->getRequest()->post('idnumber'));
        $avatar         = trim(Yii::$app->getRequest()->post('avatar'));

        $data = array(
            'level' => $level,
            'realname'      => $realname,
            'mobile'        => $mobile,
            'membertype'    => $membertype,
            'email'         => $email,
            'idnumber'      => $idnumber,
            'avatar'        => $avatar,
            'modified' => time()
        );

        $row = User::find()->where("mobile='{$mobile}' and id <> $id")->one();
        if(!empty($row)) $this->exitJSON(0, '手机号已存在！');
        if( $id ){
            $user = User::findOne( $id );
            if( !empty($password) ) $data['password'] = $user->generatePasswordHash($password);
            $rtn = $user->updateAttributes($data);
        }else{
            if(empty($username)) $this->exitJSON(0, '用户名不能为空！');
            if(empty($password)) $this->exitJSON(0, '密码不能为空！');

            $user = new User();
            $data['username'] = $username;
            $data['auth_key'] = $user->generateAuthKey();
            $data['password'] = $user->generatePasswordHash($password);
            $data['usertoken'] = $user->generateUserToken();
            $data['created'] = time();
            $data['status'] = User::STATUS_ACTIVE;

            $user->setAttributes($data, false);
            $rtn = $user->insert();
        }

        if( $rtn ){
            $this->exitJSON(1, 'Success!');
        }else{
            $this->exitJSON(0, 'Fail!');
        }
    }
}