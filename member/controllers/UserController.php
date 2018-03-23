<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/8/28
 * Time: 14:42
 */

namespace member\controllers;

use common\helpers\Func;
use common\models\User;
use yii\helpers\FileHelper;
use yii\data\Pagination;
use yii\widgets\LinkPager;
use Yii;

class UserController extends BaseController
{
    /**
     * 下线列表
     * @return string
     */
    public function actionIndex(){
        $user_id = Yii::$app->user->getId();
        $query = User::find()->andWhere("`upline_id` = '{$user_id}'");
        $searchData = $this->searchForm($query, ['id', 'username', 'ylmguid','is_activated']);
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

    public function actionProfile(){

        if( Yii::$app->getRequest()->getIsPost() ){
            $model = User::findOne(Yii::$app->user->getId());
            if ($model === null) {
                throw new NotFoundHttpException();
            }
            $attributeNames = array('nickname', 'avatar', 'email', 'realname', 'idnumber');
            if ($model->load(Yii::$app->request->post()) && $model->save(true, $attributeNames)) {
                $this->exitJSON(1, 'success!');
            }else{
                $this->exitJSON(0, 'fail!');
            }
        }else{
            $renderData = array();
            $renderData['model'] = Yii::$app->user->getIdentity();
            return $this->display('profile', $renderData);

        }
    }

    public function actionPassword(){
        if( Yii::$app->getRequest()->getIsPost() ){
            $oldpassword = Yii::$app->getRequest()->post('oldpassword');
            $newpassword = Yii::$app->getRequest()->post('newpassword');
            $repassword = Yii::$app->getRequest()->post('repassword');

            if(empty($oldpassword)) $this->exitJSON(0, '请输入旧密码！');
            if(empty($newpassword)) $this->exitJSON(0, '请输入新密码！');
            if(empty($repassword)) $this->exitJSON(0, '重复新密码不能为空！');
            if($newpassword != $repassword) $this->exitJSON(0, '两次输入密码不一致！');

            $model = User::findOne(Yii::$app->user->getId());
            if( !$model->validatePassword($oldpassword) ) $this->exitJSON(0, '旧密码输入不正确！');

            $model->password = $model->generatePasswordHash($newpassword);
            if(Yii::$app->user->getId() == 1) $model->editinitpwd = 1;
            if($model->save()){
                $this->exitJSON(1, '操作成功！');
            }
            $this->exitJSON(0, '操作失败！');

        }else{

            return $this->display('password');
        }
    }

    public function actionMobile(){

        if( Yii::$app->getRequest()->getIsPost() ){
            $mobile = Yii::$app->getRequest()->post('mobile');
            $yzm = Yii::$app->getRequest()->post('yzm');

            if(empty($mobile)) $this->exitJSON(0, '请输入手机号！');
            if(empty($yzm)) $this->exitJSON(0, '请输入验证码！');

            if( !Func::checkVerifyCode($yzm, $mobile) ) $this->exitJSON(0, '验证码错误！');

            $model = User::findOne(Yii::$app->user->getId());
            $model->mobile = $mobile;
            if($model->save()){
                $this->exitJSON(1, '操作成功！');
            }
            $errors = $model->getFirstErrors();
            $this->exitJSON(0, '操作失败！'.array_shift($errors));

        }else{
            $renderData = array();
            $renderData['model'] = Yii::$app->user->getIdentity();
            return $this->display('mobile', $renderData);
        }
    }

    public function actionAccount(){

        $user = Yii::$app->user->getIdentity()->getAttributes();
        $renderData = array('user' => $user);
        return $this->display('account', $renderData);
    }
    public function actionMyRecommender(){

        $recommenders = User::find()
            ->where(['recommenderid' => Yii::$app->user->getId()])
            ->all();

        $renderData = ['recommenders' => $recommenders];
        return $this->display('my-recommender', $renderData);
    }
    public function actionUploadAvatar(){
        $base64Str = trim(Yii::$app->getRequest()->post('base64'));

        if (preg_match('/^(data:\s*image\/(\w+);base64,)/', $base64Str, $result)) {

            $fileName = '/image/'.date("Ymd").'/'.uniqid().'.'.$result[2];
            $filePath = Yii::getAlias('@static').$fileName;

            if (!is_dir( dirname($filePath) )) {
                FileHelper::createDirectory(dirname($filePath));
            }

            if (file_put_contents($filePath, base64_decode(str_replace($result[1], '', $base64Str)))) {
                $size = filesize($filePath);
                $imagesizeArr = getimagesize($filePath);
                if( $size > 2*1024*1024){
                    unlink($filePath);
                    $this->exitJSON(0, '文件大小不能超过2M!');
                }
                if( !in_array($imagesizeArr['mime'], array('image/jpeg', 'image/gif', 'image/jpg', 'image/png')) ){
                    unlink($filePath);
                    $this->exitJSON(0, '仅支持jpeg,gif,jpg,png格式图片!');
                }
                $model = User::findOne(Yii::$app->user->getId());
                $model->avatar = $fileName;
                if($model->save()){
                    $this->exitJSON(1, '操作成功！');
                }
                $errors = $model->getFirstErrors();
                $this->exitJSON(0, '操作失败！'.array_shift($errors));
            }
            $this->exitJSON(0, 'Upload Fail!');
        }
    }
    /**
     * 添加代理下线
     */
    public function actionAdd(){

        if(Yii::$app->getRequest()->getIsPost()){
            $this->doForm();
        }else{
            $renderData = [];
            return $this->display('form', $renderData);
        }
    }
    private function doForm(){

        $id = intval( Yii::$app->getRequest()->post('id') );
        $username = trim(Yii::$app->getRequest()->post('username'));
        $password = trim(Yii::$app->getRequest()->post('password'));
        $realname = trim(Yii::$app->getRequest()->post('realname'));
        $mobile   = trim(Yii::$app->getRequest()->post('mobile'));
        $level = Yii::$app->user->getIdentity()->level;

        $membertype     = intval(Yii::$app->getRequest()->post('membertype'));
        $email          = trim(Yii::$app->getRequest()->post('email'));
        $idnumber       = trim(Yii::$app->getRequest()->post('idnumber'));
        $avatar         = trim(Yii::$app->getRequest()->post('avatar'));

        $data = array(
            'level' => $level + 1,
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
            $judge_result = $this->actionJudgeInfo($user);
            if($judge_result) {
                if( !empty($password) ) $data['password'] = $user->generatePasswordHash($password);
                $rtn = $user->updateAttributes($data);
            }else{
                $this->exitJSON(0, '要修改者的id不正确！');
            }
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
            $data['upline_id'] = Yii::$app->user->getId();
            $data['province'] = Yii::$app->user->getIdentity()->province;
            $data['city'] = Yii::$app->user->getIdentity()->city;
            $data['country'] = Yii::$app->user->getIdentity()->country;

            $user->setAttributes($data, false);
            $rtn = $user->insert();
        }

        if( $rtn ){
            $this->exitJSON(1, 'Success!');
        }else{
            $this->exitJSON(0, 'Fail!');
        }
    }
    /**
     * 判断是否为空且要修改的对象是不是此账号的下级
     */
    public function actionJudgeInfo($user)
    {
        if(!empty($user)) {
            if($user['upline_id'] == Yii::$app->user->getId()){
                return true;
            }else{
                return false;
            }
        }else{
            return false;
        }
    }
    /**
     * 激活代理商
     */
    public function actionActivate(){
        $id = intval( Yii::$app->getRequest()->get('id') );

        if( $id ){
            $user = User::findOne( $id );
            $judge_result = $this->actionJudgeInfo($user);
            if($judge_result) {
                $user->updateAttributes(['is_activated' => User::ACTIVATED_YES, 'activated_time' => time()]);
            } else {
                $this->exitJSON(0, '要修改者的id不正确！');
            }
        }
        $this->exitJSON(1, 'Success!');
    }
    public function actionEdit(){
        if(Yii::$app->getRequest()->getIsPost()){
            $this->doForm();
        }else {
            $id = intval(Yii::$app->getRequest()->get('id'));
            $row = User::findOne(['id' => $id]);
            $judge_result = $this->actionJudgeInfo($row);
            if($judge_result) {
                $renderData = ['row' => $row];
                return $this->display('form', $renderData);
            }
        }
    }
    public function actionDelete(){
        $id = intval( Yii::$app->getRequest()->get('id') );
        if( $id ){
            $user = User::findOne( $id );
            $judge_result = $this->actionJudgeInfo($user);
            if($judge_result) {
                $user->updateAttributes(['status' => User::STATUS_DELETED]);
            } else {
                $this->exitJSON(0, '要修改者的id不正确！');
            }
        }
        $this->exitJSON(1, 'Success!');
    }
    public function actionRelieve(){
        $id = intval( Yii::$app->getRequest()->get('id') );
        if( $id ){
            $user = User::findOne( $id );
            $judge_result = $this->actionJudgeInfo($user);
            if($judge_result) {
                $user->updateAttributes(['status' => User::STATUS_ACTIVE]);
            } else {
                $this->exitJSON(0, '要修改者的id不正确！');
            }
        }
        $this->exitJSON(1, 'Success!');
    }
}