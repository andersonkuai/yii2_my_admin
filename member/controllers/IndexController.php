<?php
namespace member\controllers;

use common\helpers\Func;
use Yii;
use common\models\User;
use yii\web\Controller;

class IndexController extends Controller
{

    public function actionLogin(){
        $errors = [];
        if (!Yii::$app->user->getIsGuest()) {
            return $this->goHome();
        }
        if( Yii::$app->getRequest()->getIsPost() ){
            $username = trim(Yii::$app->getRequest()->post('username'));
            $password = trim(Yii::$app->getRequest()->post('password'));
            $remember = intval(Yii::$app->getRequest()->post('remember'));

            if(empty($username)) $errors[] = '用户名不能为空！';
            if(empty($password)) $errors[] = '密码不能为空！';
            $user = User::findByUsername($username);
            if( empty($errors) && !empty($user) && $user->validatePassword($password) ) {
                Yii::$app->user->login($user, $remember ? 3600 * 24 * 30 : 0);

                $user->lastlogin_time = time();
                $user->lastlogin_ip = Func::getClientIp();
                $user->usertoken = $user->generateUserToken();
                $user->save();

                if($user->id == 1 && $user->editinitpwd == 0) Yii::$app->user->setReturnUrl(['user/password']);
                return $this->goBack();
            }else{
                $errors[] = '账号或者密码错误！';
            }
        }
        $renderData['errors'] = $errors;
        return $this->renderPartial('login', $renderData );
    }
    public function actionLogout(){
        Yii::$app->user->logout();

        return $this->goHome();
    }
    public function actionRegister(){
        exit('注册功能已关闭');
        $errors = [];
        if( Yii::$app->getRequest()->getIsPost() ){
            $username = trim(Yii::$app->getRequest()->post('username'));
            $password = trim(Yii::$app->getRequest()->post('password'));
            $repassword = trim(Yii::$app->getRequest()->post('repassword'));
            $mobile = trim(Yii::$app->getRequest()->post('mobile'));
            $code = intval(Yii::$app->getRequest()->post('code'));
            $agree = intval(Yii::$app->getRequest()->post('agree'));
            $recommenderid = intval(Yii::$app->getRequest()->post('recommenderid'));
            if(!$recommenderid) $recommenderid = 1;

            if(empty($username)) $errors[] = '用户名不能为空！';
            if( strlen($username) < 6 || strlen($username) > 20 ) $errors[] = '用户名6~20字符！';
            if(empty($password)) $errors[] = '密码不能为空！';
            if( strlen($password) < 6 || strlen($password) > 20 ) $errors[] = '密码6~20字符！';
            if(empty($repassword)) $errors[] = '确认密码不能为空！';
            if($password != $repassword) $errors[] = '两次密码输入不一致！';
            if(empty($mobile)) $errors[] = '手机号不能为空！';
            if(empty($code)) $errors[] = '验证码不能为空！';
            if(empty($agree)) $errors[] = '请同意注册条款！';
            if(!Func::checkMobile($mobile)) $errors[] = '手机号格式错误！';
            if(!Func::checkVerifyCode($code, $mobile) ) $errors[] = '验证码错误！';

            $row = User::find()->where("mobile='{$mobile}'")->one();
            if(!empty($row)) $errors[] = '手机号已存在！';

            $row = User::findOne($recommenderid);
            if(empty($row)) $errors[] = '推荐人不存在！';

            if( empty($errors) ){
                $user = new User();
                $data = array(
                    'username' => $username,
                    'auth_key' => $user->generateAuthKey(),
                    'password' => $user->generatePasswordHash($password),
                    'created' => time(),
                    'status' => User::STATUS_ACTIVE,
                    'nickname'      => 'FD'.rand(10000, 99999),
                    'realname'      => '',
                    'mobile'        => $mobile,
                    'membertype'    => 0,
                    'email'         => '',
                    'idnumber'      => '',
                    'recommenderid' => $recommenderid,
                    'recommenders'  => implode(',', User::getRecommenders($recommenderid, 10)),
                    'avatar'        => '/avatar/avatar5.png',
                    'modified'      => time(),
                    'usertoken'     => $user->generateUserToken()
                );

                $user->setAttributes($data);
                $rtn = $user->insert();
                if(!$rtn){
                    $firstErrors = $user->getFirstErrors();
                    $errors[] = array_shift($firstErrors);
                }else{
                    return Yii::$app->getResponse()->redirect(Yii::$app->user->loginUrl);
                }
            }
        }
        $renderData['errors'] = $errors;
        return $this->renderPartial('register', $renderData );
    }

    public function actionTest(){

    }
}