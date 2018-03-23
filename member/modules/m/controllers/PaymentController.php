<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/10/24
 * Time: 15:09
 */

namespace member\modules\m\controllers;

use common\classes\PaymentSuccess;
use common\classes\UserOperate;
use common\enums\RedPoint;
use common\helpers\Func;
use common\models\Payment;
use Yii;

class PaymentController extends MobileBaseController
{
    public function actionIndex(){

        if( Yii::$app->getRequest()->getIsPost() ){
            /*
            $id = trim(Yii::$app->getRequest()->post('id'));
            $channel = trim(Yii::$app->getRequest()->post('channel'));
            $model = Payment::findOne(['id' => $id, 'paid' => 0]);
            if(empty($model) || $model['time_expire'] < time()) $this->exitJSON(0, '订单不存在，或订单已失效！');
            if( !key_exists($channel, Func::params('payment.channel'))) $this->exitJSON(0, '充值方式错误！');

            $model->setAttributes([
                'channel' => $channel,
                'paid' => 1,
                'transaction_no' => 'test'.uniqid().rand(10, 99),
                'time_paid' => time()
            ]);
            $rtn = $model->save();
            if(!$rtn){
                $this->exitJSON(0, '支付失败！');
            }
            PaymentSuccess::callback($model);
            $uid = Yii::$app->user->getId();
            Notification::createNoti('user_recharge', $channel, $model['amount'], 0, 'system', $uid, 'normal_user');
            $this->exitJSON(1, '支付成功！');
            */
        }else{
            $id = trim(Yii::$app->getRequest()->get('id'));
            $row = Payment::findOne(['id' => $id, 'paid' => 0]);
            if(empty($row) || $row['time_expire'] < time()) $this->showMsg('订单不存在，或订单已失效！');
            $renderData = ['row' => $row, 'order_sn' => $id];
            return $this->render('index', $renderData);
        }
    }

    public function actionPingplusCharge(){
        require_once ( Yii::getAlias('@common/extensions/pingplusplus/init.php') );

        $app_id  = Yii::$app->params['pingplus']['app_id'];
        //$app_key = Yii::$app->params['pingplus']['app_test_key'];
        $app_key = Yii::$app->params['pingplus']['app_key'];

        $order_sn = trim(Yii::$app->getRequest()->post('order_sn'));
        $channel = trim(Yii::$app->getRequest()->post('channel'));//alipay,wx
        if(!in_array($channel, array( 'alipay', 'wx' ))) $this->exitJSON( 0, 'Non payment support!' );

        $row = Payment::findOne(['id' => $order_sn, 'paid' => 0]);
        if(empty($row) || $row['time_expire'] < time()) $this->exitJSON(0, '订单不存在，或订单已失效！');

        $charge_data = array(
            'subject'	=> 'User recharge',//商品名称
            'order_no'  => $order_sn,//订单号
            'amount'    => $row['amount'],
            'app'       => array('id'=>$app_id),
            'channel'   => $channel,
            'currency'  => 'cny',
            'client_ip' => Func::getClientIp(),
            'body'      => 'User recharge',
            'metadata'  => array( 'action' => 'fundpay' )
        );
        \Pingpp\Pingpp::setApiKey($app_key);
        try {
            $ch = \Pingpp\Charge::create($charge_data);
            $this->exitJSON(1, 'success!', json_decode($ch, true));
        } catch (\Pingpp\Error\Base $e) {
            // 捕获报错信息
            if ($e->getHttpStatus() != null) {
                header('Status: ' . $e->getHttpStatus());
                //echo $e->getHttpBody();
                $this->exitJSON(0, $e->getHttpBody());
            } else {
                //echo $e->getMessage();
                $this->exitJSON(0, $e->getMessage());
            }
        }
    }
    public function actionRedpointCharge(){

        $order_sn = trim(Yii::$app->getRequest()->post('order_sn'));
        $channel = trim(Yii::$app->getRequest()->post('channel'));//alipay,wx
        if(!in_array($channel, array( 'redpoint'))) $this->exitJSON( 0, 'Non payment support!' );

        $model = Payment::findOne(['id' => $order_sn, 'paid' => 0]);
        if(empty($model) || $model['time_expire'] < time()) $this->exitJSON(0, '订单不存在，或订单已失效！');
        $amount = abs($model['amount']);
        $rate = \common\helpers\Func::getReturnConfig('red_stock_rates');
        $needRedNum = $amount * (1+$rate);
        if(Yii::$app->user->identity->redpoint < $needRedNum) $this->exitJSON(0, '红积分余额不足！');

        try {
            list($code, $msg) = UserOperate::redPoint([
                'uid' => Yii::$app->user->getId(),
                'trade_type' => RedPoint::TRADE_TYPE_PAY,
                'num' => -$needRedNum,
                'other_uid' => 0,
                'other_type' => RedPoint::OTHER_TYPE_SYSTEM,
                'other_name' => RedPoint::label(RedPoint::OTHER_TYPE_SYSTEM),
                'mark' => '红积分支付',
                'trade_no' => $order_sn
            ]);
        } catch(\Exception $e) {
            $this->exitJSON(0, $e->getMessage());
        }
        if( $code ){
            $model->setAttributes([
                'channel' => $channel,
                'paid' => 1,
                'transaction_no' => 'rd' . uniqid() . rand(1000, 9999),
                'time_paid' => time()
            ]);
            $rtn = $model->save();
            if(!$rtn){
                $this->exitJSON(0, '更新订单异常！');
            }
            PaymentSuccess::callback($model);
            $this->exitJSON(1, 'success!');
        }else{

            $this->exitJSON(0, $msg);
        }
    }
}