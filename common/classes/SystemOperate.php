<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/9/6
 * Time: 9:39
 */

namespace common\classes;


use common\enums\OrderType;
use common\enums\StockPoint;
use common\enums\WhitePoint;
use common\helpers\Func;
use common\models\CashpoolDetail;
use common\models\Payment;
use common\models\SysInfo;
use common\models\User;
use common\models\UserConsume;
use common\models\UserRecharge;
use common\models\UserStockpointDetail;
use common\models\UserWhitepointDetail;
use yii\db\Exception;

class SystemOperate
{
    //$money 分
    public static function cash($flowtype, $money, $uid, $mark){

        $sysInfo = SysInfo::findOne(1);
        $transaction = CashpoolDetail::getDb()->beginTransaction();
        $premoney = $sysInfo->cash;
        $aftermoney = $sysInfo->cash + $money;
        try {
            $sysInfo->cash = $sysInfo->cash + $money;
            if( $money >= 0 ){
                $sysInfo->cash_intotal = $sysInfo->cash_intotal + $money;
            }else{
                $sysInfo->cash_outtotal = $sysInfo->cash_outtotal - ($money);
            }
            if(!$sysInfo->update())
                throw new Exception(array_values($sysInfo->getFirstErrors())[0]);

            $data = [
                'flowtype' => $flowtype,
                'money' => $money,
                'premoney' => $premoney,
                'aftermoney' => $aftermoney,
                'uid' => $uid,
                'mark' => $mark,
                'created' => time()
            ];
            $cpd = new CashpoolDetail();
            $cpd->setAttributes($data);
            if(!$cpd->insert())
                throw new Exception(array_values($cpd->getFirstErrors())[0]);

            $transaction->commit();
            return [1, 'success'];
        } catch(\Exception $e) {
            $transaction->rollBack();
            throw $e;
        }

        return [0, 'fail'];
    }
    //撤销积分
    public static function cancelConsume( $consumeSn, $point = null ){
        $consume = UserConsume::findOne([ 'consume_sn'=> $consumeSn]);
        if(empty($consume)) return [0, '消费订单不存在'];
        if( !in_array($consume->trade_status, [1,4])) return [0, '该消费订单不能撤销'];

        $sellerUser  = User::findOne(['id' => $consume->seller_uid]);
        $consumeUser = User::findOne(['id' => $consume->consume_uid]);

        $stockDetail = UserStockpointDetail::findOne([
            'uid'        => $consume->seller_uid,
            'trade_type' => StockPoint::TRADE_TYPE_CONSUME_GIVE,
            'trade_no'   => $consumeSn,
            'other_uid'  => $consume->consume_uid
        ]);

        $whiteDetail = UserWhitepointDetail::findOne([
            'uid'        => $consume->consume_uid,
            'trade_type' => WhitePoint::TRADE_TYPE_CONSUME_GET,
            'trade_no'   => $consumeSn,
            'other_uid'  => $consume->seller_uid
        ]);

        if(empty($stockDetail) || empty($whiteDetail) || ($stockDetail->trade_num + $whiteDetail->trade_num) != 0)
            return [0, '数据异常'];
        if($point == null){
            $num = abs($stockDetail->trade_num);
        }elseif($point > $consume->point){
            return [0, '撤销数量大于原始数量'];
        }else{
            $num = abs($point);
        }
        $revokeRate = sprintf('%.2f', $num/$consume->point);//撤销比例

        $data1 = [
            'uid' => $stockDetail->uid,
            'trade_type' => StockPoint::TRADE_TYPE_CONSUME_CANCEL,
            'trade_num' => $num,
            'trade_time' => time(),
            'trade_prenum' => $sellerUser->stockpoint,
            'trade_afternum' => $sellerUser->stockpoint + $num,
            'mark' => '客户消费撤销，归还',
            'trade_no' => $consumeSn,
            'other_uid' => $stockDetail->other_uid,
            'other_type' => $stockDetail->other_type,
            'other_name' => $stockDetail->other_name,
            'ymd' => date('Ymd'),
            'retype' => 1
        ];

        $data2 = [
            'uid' => $whiteDetail->uid,
            'trade_type' => WhitePoint::TRADE_TYPE_CONSUME_CANCEL,
            'trade_num' => -$num,
            'trade_time' => time(),
            'trade_prenum' => $consumeUser->whitepoint,
            'trade_afternum' => $consumeUser->whitepoint - $num,
            'mark' => '客户消费撤销，归还',
            'trade_no' => $consumeSn,
            'other_uid' => $whiteDetail->other_uid,
            'other_type' => $whiteDetail->other_type,
            'other_name' => $whiteDetail->other_name,
            'ymd' => date('Ymd'),
            'retype' => 0
        ];
        $transaction = User::getDb()->beginTransaction();
        try {
            //归还商家扣除的库存积分
            $sellerUser->stockpoint = $sellerUser->stockpoint + $num;
            if(!$sellerUser->update())
                throw new Exception(array_values($sellerUser->getFirstErrors())[0]);

            $uspd = new UserStockpointDetail();
            $uspd->setAttributes($data1);
            if(!$uspd->insert())
                throw new Exception(array_values($uspd->getFirstErrors())[0]);

            //扣除消费者得到的白积分
            $consumeUser->whitepoint = $consumeUser->whitepoint - $num;
            if(!$consumeUser->update())
                throw new Exception(array_values($consumeUser->getFirstErrors())[0]);

            $uwpd = new UserWhitepointDetail();
            $uwpd->setAttributes($data2);
            if(!$uwpd->insert())
                throw new Exception(array_values($uwpd->getFirstErrors())[0]);

            $consume->trade_status = $revokeRate == 1 ? 3:4;
            if(!$consume->update() && !empty($consume->getFirstErrors()))
                throw new Exception(array_values($consume->getFirstErrors())[0]);

            $transaction->commit();
            //return [1, 'success'];
        } catch(\Exception $e) {
            $transaction->rollBack();
            return [0, $e->getMessage()];
        }

        //撤销分成白积分
        $commissionArr = UserWhitepointDetail::find()
            ->where(['trade_type' => WhitePoint::TRADE_TYPE_CONSUME_COMM, 'trade_no'   => $consumeSn])
            ->all();

        if(!empty($commissionArr)){
            foreach($commissionArr as $model){

                $currentUser = User::findOne($model->uid);
                $currentNum  = $currentUser->whitepoint - $model->trade_num*$revokeRate > 0 ? $model->trade_num*$revokeRate : $currentUser->whitepoint;
                $currentNum = sprintf('%.2f', $currentNum);
                UserOperate::whitePoint([
                    'uid' => $model->uid,
                    'trade_type' => WhitePoint::TRADE_TYPE_CONSUME_COMM_CANCEL,
                    'num' => -$currentNum,
                    'other_uid' => 0,
                    'other_type' => WhitePoint::OTHER_TYPE_SYSTEM,
                    'other_name' => WhitePoint::label(WhitePoint::OTHER_TYPE_SYSTEM),
                    'mark' => '客户消费撤销，'.$model->mark,
                    'trade_no' => $consumeSn
                ]);

            }
        }

        return [1, 'success'];
    }

    /**
     * 委托充值
     * @param $uid 用户ID
     * @param $money 充值金额
     * @return array
     */
    public static function entrustRecharge($uid, $money){
        $sys_app = Func::params("system.app");
        $appid = $sys_app[1001]['appid'];
        $charge_money = Func::trMoney($money);

        $user = User::findOne(['id' => $uid]);
        if(empty($user)) return [0, '用户不存在'];
        if( $charge_money <= 0 ) return [0, '充值金额必须大于0'];

        $recharge = new UserRecharge();
        $payment = new Payment();
        $transaction = UserRecharge::getDb()->beginTransaction();

        try{
            $data_1 = [
                'appid' => $appid,
                'recharge_sn' => $recharge->generateRechargeSn(),
                'recharge_uid' => $uid,
                'money' => $charge_money,
                'trade_status' => 'created',
                'created' => time(),
                'ymd'     => date('Ymd'),
                'time_paid' => 0,
            ];
            $recharge->setAttributes($data_1);
            if(!$recharge->insert())
                throw new Exception(array_values($recharge->getFirstErrors())[0]);
            $data_2 = [
                'id' => $payment->generateId(),
                'appid' => $appid,
                'amount' => $recharge['money'],
                'amount_refunded' => 0,
                //'paid' => 0,
                'refunded' => 0,
                'reversed' => 0,
                //'channel' => '',
                //'transaction_no' => '',
                'extra' => '',
                'order_type' => OrderType::FUND_RECHARGE,
                'order_no' => $recharge['recharge_sn'],
                'client_ip' => Func::getClientIp(),
                'subject' => '用户充值库存积分',
                'body' => '用户充值库存积分',
                'failure_code' => '',
                'failure_msg' => '',
                'metadata' => '',
                'description' => '用户充值库存积分',
                'time_expire' => time() + 3*3600,
                //'time_paid' => 0,
                'created' => time(),
                'channel' => 'ylmg',
                'paid' => 1,
                'transaction_no' => 'ylmg'.uniqid().rand(10, 99),
                'time_paid' => time()
            ];

            $payment->setAttributes($data_2);
            if(!$payment->insert())
                throw new Exception(array_values($payment->getFirstErrors())[0]);

            $transaction->commit();
        } catch(\Exception $e) {
            $transaction->rollBack();
            return [0, $e->getMessage()];
        }
        PaymentSuccess::callback($payment);
        return [1, 'success'];
    }
}