<?php
namespace backend\controllers;

use common\helpers\Func;
use Yii;
use backend\models\Admin;
use yii\helpers\Inflector;
use yii\web\ForbiddenHttpException;
use yii\web\Controller;

class IndexController extends Controller
{

    public function actionLogin(){
        $errors = array();
        if (!Yii::$app->user->getIsGuest()) {
            return $this->goHome();
        }
        if( Yii::$app->getRequest()->getIsPost() ){
            setcookie('language',trim(Yii::$app->getRequest()->post('language')));//设置语言
            $username = trim(Yii::$app->getRequest()->post('username'));
            $password = trim(Yii::$app->getRequest()->post('password'));
            $remember = intval(Yii::$app->getRequest()->post('remember'));

            if(empty($username)) $errors[] = '用户名不能为空！';
            if(empty($password)) $errors[] = '密码不能为空！';
            $admin = Admin::findByUsername($username);

            if( empty($errors) && !empty($admin) && $admin->validatePassword($password) ) {
                Yii::$app->user->login($admin, $remember ? 3600 * 24 * 30 : 0);
                //更新用户登录时间 ip
                Yii::$app->user->identity->login_time = time();
                Yii::$app->user->identity->login_ip = Func::getClientIp();
                Yii::$app->user->identity->update();
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
    public function actionRbacInit(){
        if (Yii::$app->user->getIsGuest() || Yii::$app->user->getId() != 1) {
            throw new ForbiddenHttpException('你没有权限！');
        }
        define("NEWLINE", "<br/>");
        $auth = Yii::$app->authManager;
        //1.添加权限
        $auth->removeAll();
        echo "1.[Add] Permission ..." . NEWLINE;
        if ($dh = opendir(__DIR__)){
            while (($file = readdir($dh)) !== false){
                if( $file != '.' && $file != '..' ){
                    $className = basename($file,".php");
                    $controllerName = substr($className,0, -10);
                    if( in_array($controllerName, array('Base')) ) continue;
                    $controllerId = Inflector::camel2id($controllerName);
                    $class = new \ReflectionClass(__NAMESPACE__ . "\\" .  $className);
                    $methods = $class->getMethods(\ReflectionMethod::IS_PUBLIC );

                    $createPermController = $auth->createPermission($controllerId);
                    $createPermController->description = $controllerName;
                    $auth->add($createPermController);
                    echo '--Add Permission '.$controllerId . NEWLINE;
                    foreach( (array) $methods as $value ){
                        if( strncmp( $value->name, 'action', 6 ) === 0 && $value->name != "actions"){
                            $actionName = substr($value->name, 6);
                            $actionId = Inflector::camel2id($actionName);

                            $createPermAction = $auth->createPermission($controllerId . '.' . $actionId);
                            $createPermAction->description = $controllerName . ' ' . $actionName;
                            $auth->add($createPermAction);
                            $auth->addChild($createPermController, $createPermAction);
                            echo '----Add Child Permission '.$controllerId . '.' . $actionId . NEWLINE;
                        }
                    }
                }
            }
            closedir($dh);
        }

        //2.添加角色
        echo "2.[Add] Role [admin] ..." . NEWLINE;
        $admin = $auth->createRole('role-admin');
        $admin->description = "超级管理员";
        $auth->add($admin);

        //3.角色权限关联
        echo "3.[Relate] Role with Permission ..." . NEWLINE;
        $perms = $auth->getPermissions();
        foreach( $perms as $perm){
            $auth->addChild($admin, $perm);
        }
        echo "4.[Relate] Role with User ..." . NEWLINE;
        //4.USER赋予角色
        $auth->assign( $admin, 1 );
    }


    public function actionTest(){



        $values = \common\enums\WhitePoint::labels();


        print_r($values);

        echo \common\enums\WhitePoint::label(1);

    }
}