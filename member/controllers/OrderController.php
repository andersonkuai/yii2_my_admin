<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/8/29
 * Time: 15:33
 */

namespace member\controllers;

use common\classes\DelayTask;
use common\classes\UserOperate;
use common\models\User;
use Yii;
use common\models\UserConsume;
use yii\data\Pagination;
use yii\widgets\LinkPager;
use common\helpers\Func;
use backend\models\Order;

class OrderController extends BaseController
{
    //订单列表
    public function actionIndex(){
        $province = Yii::$app->user->getIdentity()->province;
        $city = Yii::$app->user->getIdentity()->city;
        $country = Yii::$app->user->getIdentity()->country;

        $pay_status = Yii::$app->getRequest()->get('pay_status') != '' ? trim(Yii::$app->getRequest()->get('pay_status')) : "";//付款状态
        $goods_status = Yii::$app->getRequest()->get('goods_status') != '' ? trim(Yii::$app->getRequest()->get('goods_status')) : "";//货物状态
        $status = Yii::$app->getRequest()->get('status') != '' ? trim(Yii::$app->getRequest()->get('status')) : "";//订单状态
        $starttime = Yii::$app->getRequest()->get('starttime') != '' ? trim(Yii::$app->getRequest()->get('starttime')) : date('Y-m-d', strtotime('-1 week'));
        $endtime = Yii::$app->getRequest()->get('endtime') != '' ? trim(Yii::$app->getRequest()->get('endtime')) : date('Y-m-d');
        $order_sn = Yii::$app->getRequest()->get('order_sn') != '' ? trim(Yii::$app->getRequest()->get('order_sn')) : '';
        $g_id = Yii::$app->getRequest()->get('g_id') != '' ? trim(Yii::$app->getRequest()->get('g_id')) : '';
        $goods_name = Yii::$app->getRequest()->get('goods_name') != '' ? trim(Yii::$app->getRequest()->get('goods_name')) : '';
        $user_id = Yii::$app->getRequest()->get('user_id') != '' ? trim(Yii::$app->getRequest()->get('user_id')) : '';
        $user_name = Yii::$app->getRequest()->get('user_name') != '' ? trim(Yii::$app->getRequest()->get('user_name')) : '';
        $nickname = Yii::$app->getRequest()->get('nickname') != '' ? trim(Yii::$app->getRequest()->get('nickname')) : '';
        $shipname = Yii::$app->getRequest()->get('shipname') != '' ? trim(Yii::$app->getRequest()->get('shipname')) : '';
        $tel = Yii::$app->getRequest()->get('tel') != '' ? trim(Yii::$app->getRequest()->get('tel')) : '';
        $deliver_no = Yii::$app->getRequest()->get('deliver_no') != '' ? trim(Yii::$app->getRequest()->get('deliver_no')) : '';
        $orderby = Yii::$app->getRequest()->get('orderby') != '' ? trim(Yii::$app->getRequest()->get('orderby')) : 'addtime DESC';

        $vars = array(
            'pay_status' => $pay_status,
            'goods_status' => $goods_status,
            'status' => $status,
            'starttime' => $starttime,
            'endtime' => $endtime,
            'order_sn' => $order_sn,
            'g_id' => $g_id,
            'goods_name' => $goods_name,
            'user_id' => $user_id,
            'user_name' => $user_name,
            'nickname' => $nickname,
            'shipname' => $shipname,
            'tel' => $tel,
            'deliver_no' => $deliver_no,
            'orderby' => $orderby,
        );
        $andWhere = '';
        if (isset ($vars ['pay_status']) && $vars ['pay_status'] !== '') {
            $andWhere .= " and pay_status = " . intval($vars ['pay_status']);
        }
        if (isset ($vars ['goods_status']) && $vars ['goods_status'] !== '') {
            $andWhere .= " and goods_status = " . intval($vars ['goods_status']);
        }
        if (isset ($vars ['status']) && $vars ['status'] !== '') {
            $andWhere .= " and status = " . intval($vars ['status']);
        }
        if(!empty($vars['starttime'])) {$starttimeTime = strtotime($vars['starttime']); $andWhere .= " and `addtime` >= '".$starttimeTime."'";};
        if(!empty($vars['endtime'])) {$endtimeTime = strtotime($vars['endtime']) + 86399; $andWhere .= " and `addtime` <= '".$endtimeTime."'";};
        if(!empty($vars['order_sn'])) $andWhere .= " and `order_sn` = '{$vars['order_sn']}'";
        if(!empty($vars['g_id'])) $andWhere .= " and `g_id` = '{$vars['g_id']}'";
        if(!empty($vars['goods_name'])) $andWhere .= " and `goods_name` = '{$vars['goods_name']}'";
        if(!empty($vars['user_id'])) $andWhere .= " and `user_id` = '{$vars['user_id']}'";
        if(!empty($vars['user_name'])) $andWhere .= " and `user_name` = '{$vars['user_name']}'";
        if(!empty($vars['nickname'])) $andWhere .= " and `nickname` = '{$vars['nickname']}'";
        if(!empty($vars['shipname'])) $andWhere .= " and `shipname` = '{$vars['shipname']}'";
        if(!empty($vars['tel'])) $andWhere .= " and `tel` = '{$vars['tel']}'";
        if(!empty($vars['deliver_no'])) $andWhere .= " and `deliver_no` = '{$vars['deliver_no']}'";


        $where = !empty($country) ? "province= '{$province}' and city = '{$city}' and area = '{$country}' " : "province= '{$province}' and city = '{$city}' " ;
        $query = Order::find()->where($where.$andWhere)->orderBy($vars['orderby']);
        $pages = new Pagination(['totalCount' =>$query->count(), 'pageSize' => 10]);
        $list = $query->offset($pages->offset)->limit($pages->limit)->all();
        $renderData = [
            'vars' => $vars,
            'title' => '订单列表',
            'list' => $list,
            'pageHtml' => LinkPager::widget([
                'pagination' => $pages,
                'options' => ['class' => 'pagination pagination-sm no-margin pull-right']
            ])
        ];
        return $this->display('index', $renderData);
    }
    public function actionTest()
    {
        return $this->display('test');
    }
}