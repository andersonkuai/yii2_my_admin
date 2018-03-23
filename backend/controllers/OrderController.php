<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/8/24
 * Time: 9:34
 */

namespace backend\controllers;

use common\models\HiUserOrderMerge;
use yii\data\Pagination;
use yii\widgets\LinkPager;

class OrderController extends BaseController
{
    public function actionIndex(){
        $query = HiUserOrderMerge::find()->select(['hi_user_order_merge.id','hi_user_order_merge.OrderId','hi_user_order_merge.Uid','hi_user_order_merge.Trade','hi_user_order_merge.Price','hi_user_order_merge.RecvId',
                'hi_user_order_merge.Message','hi_user_order_merge.PayType','hi_user_order_merge.Status','hi_user_order_merge.SendStatus','hi_user_order_merge.CourseId',
                'hi_user_order_merge.PayTime','hi_user_order_merge.Time','hi_user_order_merge.PaymentInfo','hi_user_order_merge.DiscountPrice',
                'hi_user_merge.UserName','hi_user_merge.City',
                'hi_user_address_merge.Province','hi_user_address_merge.City','hi_user_address_merge.Area','hi_user_address_merge.Address','hi_user_address_merge.Mobile',
                'hi_conf_course.ProdName',
            ])
            ->innerJoin('hi_user_merge','hi_user_order_merge.Uid = hi_user_merge.Uid')
            ->innerJoin('hi_user_address_merge','hi_user_order_merge.RecvId = hi_user_address_merge.ID and hi_user_order_merge.Uid = hi_user_address_merge.Uid')
            ->leftJoin('hi_conf_course','hi_user_order_merge.CourseId = hi_conf_course.ID')
            ->andWhere(1);
        $status = \Yii::$app->getRequest()->get("Status");
        //默认显示已支付的订单
        if (!isset($status)){
            $_GET["Status"] = 1;
        }
        $searchData = $this->searchForm($query, ['OrderId', 'hi_user_order_merge.Uid', 'hi_user_order_merge.PayType','hi_user_order_merge.Status','hi_user_order_merge.SendStatus','hi_user_address_merge.Mobile','hi_user_merge.UserName','hi_conf_course.ProdName']);
        //下单时间
        if(!empty($_GET['Time1'])){
            $searchData['Time1'] = $_GET['Time1'];
            $activated_time = strtotime($_GET['Time1']);
            $query = $query->andWhere("hi_user_order_merge.Time >= '{$activated_time}'");
        }
        if(!empty($_GET['Time2'])){
            $searchData['Time2'] = $_GET['Time2'];
            $activated_time = strtotime($_GET['Time2']);
            $query = $query->andWhere("hi_user_order_merge.Time <= '{$activated_time}'");
        }
        $pages = new Pagination(['totalCount' =>$query->count(), 'pageSize' => 20]);
        $orders = $query->orderBy("Time desc")->offset($pages->offset)->limit($pages->limit)->asArray()->all();
        $renderData = [
            'orders' => $orders,
            'searchData' => $searchData,
            'pageHtml' => LinkPager::widget([
                'pagination' => $pages,
                'options' => ['class' => 'pagination pagination-sm no-margin pull-right']
            ])
        ];
        return $this->display('index', $renderData);
    }
}