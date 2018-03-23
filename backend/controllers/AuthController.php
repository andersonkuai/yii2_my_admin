<?php
namespace backend\controllers;

use backend\models\AuthItem;
use backend\models\AuthItemChild;
use Yii;
use backend\models\Admin;
use yii\data\Pagination;
use yii\widgets\LinkPager;

/**
 * 权限管理
 * Class AuthController
 * @package backend\controllers
 */
class AuthController extends BaseController
{
    /**
     * 管理员列表
     * @return string
     */
    public function actionUser(){

        $query = Admin::find()->andWhere(1);

        $pages = new Pagination(['totalCount' =>$query->count(), 'pageSize' => 10]);
        $users = $query->offset($pages->offset)->limit($pages->limit)->all();
        $renderData = [
            'users' => $users,
            'pageHtml' => LinkPager::widget([
                'pagination' => $pages,
                'options' => ['class' => 'pagination pagination-sm no-margin pull-right']
            ])
        ];
        return $this->display('user', $renderData);
    }

    /**
     * 添加管理员
     * @return string
     */
    public function actionUserAdd(){

        if(Yii::$app->getRequest()->getIsPost()){
            $this->userForm();
        }else{
            $renderData = [];
            return $this->display('user-form', $renderData);
        }
    }

    /**
     * 修改管理员
     * @return string
     */
    public function actionUserEdit(){
        if(Yii::$app->getRequest()->getIsPost()){
            $this->userForm();
        }else {
            $id = intval(Yii::$app->getRequest()->get('id'));
            $row = Admin::findOne(['id' => $id]);
            $renderData = ['row' => $row];
            return $this->display('user-form', $renderData);
        }
    }

    /**
     * 禁用解禁管理员（批量）
     */
    public function actionUserStatus(){
        $status = intval( Yii::$app->getRequest()->get('status'));

        $checkids =  Yii::$app->getRequest()->post('checkids');

        $rtn = Admin::updateAll(['status' => $status], ['id' => $checkids]);

        if( $rtn ){
            $this->exitJSON(1, 'Success!');
        }else{
            $this->exitJSON(0, 'Fail!');
        }
    }

    /**
     * 禁用管理员
     */
    public function actionUserDelete(){
        $id = intval( Yii::$app->getRequest()->get('id') );

        if( $id ){

            $admin = Admin::findOne( $id );
            $admin->updateAttributes(['status' => Admin::STATUS_DELETED]);
        }
        $this->exitJSON(1, 'Success!');
    }
    private function userForm(){

        $id = intval( Yii::$app->getRequest()->post('id') );
        $username = trim(Yii::$app->getRequest()->post('username'));
        $password = trim(Yii::$app->getRequest()->post('password'));
        $nickname = trim(Yii::$app->getRequest()->post('nickname'));
        $realname = trim(Yii::$app->getRequest()->post('realname'));
        $mobile   = trim(Yii::$app->getRequest()->post('mobile'));

        $data = array(
            'nickname' => $nickname,
            'realname' => $realname,
            'mobile'   => $mobile,
            'modified' => time()
        );

        if( $id ){
            $admin = Admin::findOne( $id );
            if( !empty($password) ) $data['password'] = $admin->generatePasswordHash($password);
            $rtn = $admin->updateAttributes($data);
        }else{

            if(empty($username)) $this->exitJSON(0, '用户名不能为空');
            if(empty($password)) $this->exitJSON(0, '密码不能为空');

            $admin = new Admin();
            $data['username'] = $username;
            $data['auth_key'] = $admin->generateAuthKey();
            $data['password'] = $admin->generatePasswordHash($password);
            $data['created'] = time();
            $data['status'] = Admin::STATUS_ACTIVE;

            $admin->setAttributes($data, false);
            $rtn = $admin->insert();
            $id = $admin->id;
        }

        if( $rtn ){
            $roles = Yii::$app->getRequest()->post('roles');
            if(!empty($roles)){
                Yii::$app->authManager->revokeAll($id);

                foreach($roles as $roleName){
                    $role = Yii::$app->authManager->getRole($roleName);
                    Yii::$app->authManager->assign($role, $id);
                }
            }
            $this->exitJSON(1, 'Success!');
        }else{
            $this->exitJSON(0, 'Fail!');
        }
    }

    /**
     * 权限列表
     * @return string
     */
    public function actionPerm(){

        $mAuthItem = new AuthItem();
        $perms = $mAuthItem->findAll(['where' => ['type' => 2], 'orderBy' => ['name' => 'asc']]);
//        //格式化数据列表
//        $authList = array();
//        if(!empty($perms)){
//            foreach($perms as $val){
//                $name = explode('.',$val['name']);
//                if(count($name) == 2){
//                    $authList[$name[0]]['children'][] = $name[1];
//                }elseif (count($name) == 1){
//                    $authList[$name[0]]['data'] = $val['description'];
//                }
//            }
//        }//end if
        $renderData['perms'] = $perms;
        return $this->display('perm', $renderData);
    }

    /**
     * 角色列表
     * @return string
     */
    public function actionRole(){

        $mAuthItem = new AuthItem();
        $roles= $mAuthItem->findAll(['where' => ['type' => 1], 'orderBy' => ['name' => 'asc']]);

        $renderData['roles'] = $roles;
        return $this->display('role', $renderData);
    }

    /**
     * 修改/添加 权限（角色）
     */
    public function actionItemSave(){
        $mAuthItem = new AuthItem();

        $key = trim(Yii::$app->getRequest()->post('key'));
        $name = trim(Yii::$app->getRequest()->post('name'));
        $type = trim(Yii::$app->getRequest()->post('type'));
        $description = trim(Yii::$app->getRequest()->post('description'));

        $row = $mAuthItem->findRow("name='{$name}'");

        $data = array(
            'description' => $description,
            'updated_at' => time()
        );
        if( $key ){
            $rtn = $mAuthItem->update($data, "name='{$key}'");

        }else{
            if(!empty($row)) $this->exitJSON(0, '权限标识已存在！');
            $data['name'] = $name;
            $data['type'] = $type;
            $data['created_at'] = time();

            $rtn = $mAuthItem->insert($data);
        }

        if( $rtn ){
            $this->exitJSON(1, 'success！');
        }else{
            $this->exitJSON(0, 'fail！');
        }
    }

    /**
     * 修改权限的子权限（节点）
     * @return string
     */
    public function actionParentChild(){
        $auth = Yii::$app->authManager;
        $mAuthItem = new AuthItem();
        if( Yii::$app->getRequest()->getIsPost() ){
            $name = trim(Yii::$app->getRequest()->post('name'));
            $children = Yii::$app->getRequest()->post('children');


            $row = $mAuthItem->findRow("name='{$name}'");
            if( empty($row) ) $this->showMsg('记录不存在！');
            $items= $mAuthItem->findAll([ 'orderBy' => ['type' => 'asc', 'name' => 'asc'], 'indexBy' => 'name']);

            $parent = $row['type'] == 1 ? $auth->getRole($name) : $auth->getPermission($name);
            $auth->removeChildren($parent);

            foreach ($children as $childName){
                $child = $items[$childName]['type'] == 1 ? $auth->getRole($childName) : $auth->getPermission($childName);
                $can = $auth->canAddChild($parent, $child);
                if(!$can){
                    $this->exitJSON( 0, "子节点[{$child->description}]不能添加到[{$parent->description}]节点");
                }
            }
            foreach ($children as $childName){
                $child = $items[$childName]['type'] == 1 ? $auth->getRole($childName) : $auth->getPermission($childName);
                $auth->addChild($parent, $child);
            }

            $this->exitJSON(1, 'success!');
        }else{
            $name = trim(Yii::$app->getRequest()->get('name'));
            $row = $mAuthItem->findRow("name='{$name}'");
            if( empty($row) ) $this->showMsg('记录不存在！');

            $where = [];
            $where = ['type' => 2];
            $where = "`type` = 2 and name != '{$name}'";
//            if($row['type'] == 2) $where = ['type' => 2];
            $items= $mAuthItem->findAll(['where' => $where, 'orderBy' => ['type' => 'asc', 'name' => 'asc']]);

            $children = (new AuthItemChild())->getChildren($name);

            $renderData = array(
                'items' => $items,
                'row' => $row,
                'children' => $children
            );
            return $this->display('parent-child', $renderData);
        }
    }
}