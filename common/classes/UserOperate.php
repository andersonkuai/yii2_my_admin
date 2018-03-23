<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/9/5
 * Time: 16:56
 */

namespace common\classes;

use common\enums\Order;
use common\enums\Cashpool;
use common\enums\RedPoint;
use common\enums\StockPoint;
use common\enums\WhitePoint;
use common\helpers\Func;
use common\models\CashpoolDetail;
use common\models\User;
use common\models\UserBalanceDetail;
use common\models\UserBankcard;
use common\models\UserRedpointDetail;
use common\models\UserStockpointDetail;
use common\models\UserWhitepointDetail;
use common\models\UserWithdraw;
use yii\db\Exception;

class UserOperate
{
    public static function stockPoint($arrdata){
        $defaultData = ['uid' => 0, 'trade_type' => 0, 'num' => 0, 'other_uid' => 0,
            'other_type' => 0, 'other_name' => '', 'mark' => '', 'trade_no' => ''
        ];
        $newdata    = array_merge($defaultData, $arrdata);
        $uid        = $newdata['uid'];
        $trade_type = $newdata['trade_type'];
        $num        = $newdata['num'];
        $other_uid  = $newdata['other_uid'];
        $other_type = $newdata['other_type'];
        $other_name = $newdata['other_name'];
        $mark       = $newdata['mark'];
        $trade_no   = $newdata['trade_no'];

        $num = sprintf('%.2f', $num);
        $user = User::findOne(['id' => $uid]);
        if(!$user) return [0, '用户不存在！'];
        if( $user->stockpoint + $num < 0 ) return [0, '库存积分不足！'];

        $data = [
            'uid' => $uid,
            'trade_type' => $trade_type,
            'trade_num' => $num,
            'trade_time' => time(),
            'trade_prenum' => $user->stockpoint,
            'trade_afternum' => $user->stockpoint + $num,
            'mark' => $mark,
            'trade_no' => $trade_no,
            'other_uid' => $other_uid,
            'other_type' => $other_type,
            'other_name' => $other_name,
            'ymd' => date('Ymd'),
            'retype' => $num > 0 ? 1 : 0
        ];
        $transaction = User::getDb()->beginTransaction();
        try {
            $user->stockpoint = $user->stockpoint + $num;
            if(!$user->update())
                throw new Exception(array_values($user->getFirstErrors())[0]);

            $uspd = new UserStockpointDetail();
            $uspd->setAttributes($data);
            if(!$uspd->insert())
                throw new Exception(array_values($uspd->getFirstErrors())[0]);

            $transaction->commit();
            return [1, 'success'];
        } catch(\Exception $e) {
            $transaction->rollBack();
            //throw $e;
            return [0, $e->getMessage()];
        }

        return [0, 'fail'];
    }
    public static function whitePoint($arrdata){
        $defaultData = ['uid' => 0, 'trade_type' => 0, 'num' => 0, 'other_uid' => 0,
            'other_type' => 0, 'other_name' => '', 'mark' => '', 'trade_no' => ''
        ];
        $newdata    = array_merge($defaultData, $arrdata);
        $uid        = $newdata['uid'];
        $trade_type = $newdata['trade_type'];
        $num        = $newdata['num'];
        $other_uid  = $newdata['other_uid'];
        $other_type = $newdata['other_type'];
        $other_name = $newdata['other_name'];
        $mark       = $newdata['mark'];
        $trade_no   = $newdata['trade_no'];

        $num = sprintf('%.2f', $num);
        $user = User::findOne(['id' => $uid]);
        if(!$user) return [0, '用户不存在！'];
        if( $user->whitepoint + $num < 0 ) return [0, '白积分不足！'];

        $data = [
            'uid' => $uid,
            'trade_type' => $trade_type,
            'trade_num' => $num,
            'trade_time' => time(),
            'trade_prenum' => $user->whitepoint,
            'trade_afternum' => $user->whitepoint + $num,
            'mark' => $mark,
            'trade_no' => $trade_no,
            'other_uid' => $other_uid,
            'other_type' => $other_type,
            'other_name' => $other_name,
            'ymd' => date('Ymd'),
            'retype' => $num > 0 ? 1 : 0
        ];
        $transaction = User::getDb()->beginTransaction();
        try {
            $user->whitepoint = $user->whitepoint + $num;
            if(!$user->update())
                throw new Exception(array_values($user->getFirstErrors())[0]);

            $uwpd = new UserWhitepointDetail();
            $uwpd->setAttributes($data);
            if(!$uwpd->insert())
                throw new Exception(array_values($uwpd->getFirstErrors())[0]);

            $transaction->commit();
            return [1, 'success'];
        } catch(\Exception $e) {
            $transaction->rollBack();
            //throw $e;
            return [0, $e->getMessage()];
        }

        return [0, 'fail'];
    }
    public static function redPoint($arrdata){
        $defaultData = ['uid' => 0, 'trade_type' => 0, 'num' => 0, 'other_uid' => 0,
            'other_type' => 0, 'other_name' => '', 'mark' => '', 'trade_no' => ''
        ];
        $newdata    = array_merge($defaultData, $arrdata);
        $uid        = $newdata['uid'];
        $trade_type = $newdata['trade_type'];
        $num        = $newdata['num'];
        $other_uid  = $newdata['other_uid'];
        $other_type = $newdata['other_type'];
        $other_name = $newdata['other_name'];
        $mark       = $newdata['mark'];
        $trade_no   = $newdata['trade_no'];

        $num = sprintf('%.2f', $num);
        $user = User::findOne(['id' => $uid]);
        if(!$user) return [0, '用户不存在！'];
        if( $user->redpoint + $num < 0 ) return [0, '红积分不足！'];

        $data = [
            'uid' => $uid,
            'trade_type' => $trade_type,
            'trade_num' => $num,
            'trade_time' => time(),
            'trade_prenum' => $user->redpoint,
            'trade_afternum' => $user->redpoint + $num,
            'mark' => $mark,
            'trade_no' => $trade_no,
            'other_uid' => $other_uid,
            'other_type' => $other_type,
            'other_name' => $other_name,
            'ymd' => date('Ymd'),
            'retype' => $num > 0 ? 1 : 0
        ];
        $transaction = User::getDb()->beginTransaction();
        try {
            $user->redpoint = $user->redpoint + $num;
            if(!$user->update())
                throw new Exception(array_values($user->getFirstErrors())[0]);

            $urpd = new UserRedpointDetail();
            $urpd->setAttributes($data);
            if(!$urpd->insert())
                throw new Exception(array_values($urpd->getFirstErrors())[0]);

            $transaction->commit();
            return [1, 'success'];
        } catch(\Exception $e) {
            $transaction->rollBack();
            //throw $e;
            return [0, $e->getMessage()];
        }

        return [0, 'fail'];
    }
    //客户消费 商家送积分
    public static function consumePoint($seller_id, $consume_id, $num, $trade_no){

        $seller = User::findOne($seller_id);
        $consume = User::findOne($consume_id);

        if(empty($seller)) return [0, '商家不存在'];
        if(empty($consume)) return [0, '客户不存在'];

        $num = sprintf('%.2f', $num);
        if($seller->stockpoint < $num) return [0, '库存积分不足'];
        $transaction = User::getDb()->beginTransaction();
        try {
            //商家扣库存积分
            $data = [
                'uid' => $seller_id,
                'trade_type' => StockPoint::TRADE_TYPE_CONSUME_GIVE,
                'trade_num' => -$num,
                'trade_time' => time(),
                'trade_prenum' => $seller->stockpoint,
                'trade_afternum' => $seller->stockpoint - $num,
                'mark' => '客户消费赠送积分',
                'trade_no' => $trade_no,
                'other_uid' => $consume_id,
                'other_type' => StockPoint::OTHER_TYPE_USER,
                'other_name' => $consume->nickname,
                'ymd' => date('Ymd'),
                'retype' => 0
            ];
            $seller->stockpoint = $seller->stockpoint - $num;
            if(!$seller->update())
                throw new Exception(array_values($seller->getFirstErrors())[0]);

            $uspd = new UserStockpointDetail();
            $uspd->setAttributes($data);
            if(!$uspd->insert())
                throw new Exception(array_values($uspd->getFirstErrors())[0]);

            //客户加白积分
            $data2 = [
                'uid' => $consume_id,
                'trade_type' => WhitePoint::TRADE_TYPE_CONSUME_GET,
                'trade_num' => $num,
                'trade_time' => time(),
                'trade_prenum' => $consume->whitepoint,
                'trade_afternum' => $consume->whitepoint + $num,
                'mark' => '客户消费赠送积分',
                'trade_no' => $trade_no,
                'other_uid' => $seller_id,
                'other_type' => WhitePoint::OTHER_TYPE_USER,
                'other_name' => $seller->nickname,
                'ymd' => date('Ymd'),
                'retype' => 1
            ];
            $consume->whitepoint = $consume->whitepoint + $num;
            if(!$consume->update())
                throw new Exception(array_values($consume->getFirstErrors())[0]);

            $uwpd = new UserWhitepointDetail();
            $uwpd->setAttributes($data2);
            if(!$uwpd->insert())
                throw new Exception(array_values($uwpd->getFirstErrors())[0]);

            $transaction->commit();
            return [1, 'success'];
        } catch(\Exception $e) {
            $transaction->rollBack();
            //throw $e;
            return [0, $e->getMessage()];
        }
        return [0, 'fail'];
    }

    public static function sellerCommission($seller_id, $num, $trade_no){
        $seller = User::findOne($seller_id);

        if(empty($seller)) return [0, '商家不存在'];
        $rateArr = Func::getReturnConfig('sellercommission');
        $recommenderArr = !empty($seller->recommenders) ? explode(',', $seller->recommenders):[];
        if(empty($recommenderArr)) return [0, '没有推荐人'];
        $commission = [];
        $lastNum = $num;
        foreach($recommenderArr as $key=>$uid){
            if(isset( $rateArr[$key] ) && is_numeric($uid)){
                $num = $lastNum * $rateArr[$key];
                $lastNum = $num;
                $commission[$uid] = [
                    'level' => $key+1,
                    'num'   => $num,
                    'rate'  => $rateArr[$key]
                ];
            }
        }

        if(!empty($commission)){
            foreach($commission as $uid => $row){
                self::whitePoint([
                    'uid' => $uid,
                    'trade_type' => WhitePoint::TRADE_TYPE_SELLER_COMM,
                    'num' => $row['num'],
                    'other_uid' => 0,
                    'other_type' => WhitePoint::OTHER_TYPE_SYSTEM,
                    'other_name' => WhitePoint::label(WhitePoint::OTHER_TYPE_SYSTEM),
                    'mark' => "商家[$seller_id]充值{$row['level']}级分成[{$row['rate']}]",
                    'trade_no' => $trade_no
                ]);
            }
        }

        return [1, 'success'];
    }
    public static function consumeCommission($consume_id, $num, $trade_no){
        $consume = User::findOne($consume_id);

        if(empty($consume)) return [0, '客户不存在'];
        $rateArr = Func::getReturnConfig('consumecommission');
        $recommenderArr = !empty($consume->recommenders) ? explode(',', $consume->recommenders):[];
        if(empty($recommenderArr)) return [0, '没有推荐人'];
        $commission = [];
        $lastNum = $num;
        foreach($recommenderArr as $key=>$uid){
            if(isset( $rateArr[$key] ) && is_numeric($uid)){
                $num = $lastNum * $rateArr[$key];
                $lastNum = $num;
                $commission[$uid] = [
                    'level' => $key+1,
                    'num'   => $num,
                    'rate'  => $rateArr[$key]
                ];
            }
        }

        if(!empty($commission)){
            foreach($commission as $uid => $row){
                self::whitePoint([
                    'uid' => $uid,
                    'trade_type' => WhitePoint::TRADE_TYPE_CONSUME_COMM,
                    'num' => $row['num'],
                    'other_uid' => 0,
                    'other_type' => WhitePoint::OTHER_TYPE_SYSTEM,
                    'other_name' => WhitePoint::label(WhitePoint::OTHER_TYPE_SYSTEM),
                    'mark' => "客户[$consume_id]消费{$row['level']}级分成[{$row['rate']}]",
                    'trade_no' => $trade_no
                ]);
            }

            //加入分成通知队列
            DelayTask::instance()->putToQueue('NOTICE_CONSUME_COMMISSION', $trade_no);
        }

        return [1, 'success'];
    }

    public static function exchangeRedStock($uid, $num, $rate){
        $trade_no = uniqid('ex') . rand(1000, 9999);
        $num = sprintf('%.2f', $num);
        $user = User::findOne(['id' => $uid]);

        if(empty($user)) return [0, '用户不存在'];
        if( $num > $user['redpoint'] ) return [0, '兑换余额不足'];

        $sxf_num = sprintf('%.2f', $num*$rate);
        $dz_num  = $num - $sxf_num;
        $dz_stock_num = $dz_num * Func::getReChargeStockRate();

        $data_1 = [
            'uid' => $uid,
            'trade_type' => RedPoint::TRADE_TYPE_EXCHANGE_RED_STOCK_SXF,
            'trade_num' => -$sxf_num,
            'trade_time' => time(),
            'trade_prenum' => $user->redpoint,
            'trade_afternum' => $user->redpoint - $sxf_num,
            'mark' => "红积分兑换库存积分手续费（费率[{$rate}]）",
            'trade_no' => $trade_no,
            'other_uid' => 0,
            'other_type' => RedPoint::OTHER_TYPE_SYSTEM,
            'other_name' => RedPoint::label(RedPoint::OTHER_TYPE_SYSTEM),
            'ymd' => date('Ymd'),
            'retype' => 0
        ];
        $data_2 = [
            'uid' => $uid,
            'trade_type' => RedPoint::TRADE_TYPE_EXCHANGE_RED_STOCK,
            'trade_num' => -$dz_num,
            'trade_time' => time(),
            'trade_prenum' => $user->redpoint - $sxf_num,
            'trade_afternum' => $user->redpoint - $num,
            'mark' => "红积分兑换库存积分（扣除手续费{$sxf_num}，费率[{$rate}]）",
            'trade_no' => $trade_no,
            'other_uid' => $uid,
            'other_type' => RedPoint::OTHER_TYPE_USER,
            'other_name' => $user->nickname,
            'ymd' => date('Ymd'),
            'retype' => 0
        ];
        $data_3 = [
            'uid' => $uid,
            'trade_type' => StockPoint::TRADE_TYPE_EXCHANGE_RED_STOCK,
            'trade_num' => $dz_stock_num,
            'trade_time' => time(),
            'trade_prenum' => $user->stockpoint,
            'trade_afternum' => $user->stockpoint + $dz_stock_num,
            'mark' => "红积分兑换库存积分",
            'trade_no' => $trade_no,
            'other_uid' => $uid,
            'other_type' => StockPoint::OTHER_TYPE_USER,
            'other_name' => $user->nickname,
            'ymd' => date('Ymd'),
            'retype' => 1
        ];
        $transaction = User::getDb()->beginTransaction();
        try {
            $user->redpoint = $user->redpoint - $num;
            $user->stockpoint = $user->stockpoint + $dz_stock_num;
            if(!$user->update())
                throw new Exception(array_values($user->getFirstErrors())[0]);

            $urpd = new UserRedpointDetail();
            $urpd->setAttributes($data_1);
            if(!$urpd->insert())
                throw new Exception(array_values($urpd->getFirstErrors())[0]);

            $urpd = new UserRedpointDetail();
            $urpd->setAttributes($data_2);
            if(!$urpd->insert())
                throw new Exception(array_values($urpd->getFirstErrors())[0]);

            $uspd = new UserStockpointDetail();
            $uspd->setAttributes($data_3);
            if(!$uspd->insert())
                throw new Exception(array_values($uspd->getFirstErrors())[0]);

            $transaction->commit();
            //赠送白积分
            $whiteRate = Func::getReChargeWhiteRate();
            UserOperate::whitePoint([
                'uid'       =>  $uid,
                'trade_type'=>  WhitePoint::TRADE_TYPE_EXCHANGE_RED_TO_STOCK_GET,
                'num'       =>  $num * $whiteRate,
                'other_uid' =>  0,
                'other_type'=>  WhitePoint::OTHER_TYPE_SYSTEM,
                'other_name'=>  WhitePoint::label(WhitePoint::OTHER_TYPE_SYSTEM),
                'mark'      =>  "红积分兑换库存积分赠送白积分[{$whiteRate}倍]",
                'trade_no'  =>  $trade_no
            ]);

            //商家分成 暂时关闭
            //UserOperate::sellerCommission($uid, $num, $trade_no);

            return [1, 'success'];
        } catch(\Exception $e) {
            $transaction->rollBack();
            //throw $e;
            return [0, $e->getMessage()];
        }

        return [0, 'fail'];

    }

    public static function exchangeWhiteBalance($uid, $num, $rate){
        $trade_no = uniqid('ex') . rand(1000, 9999);
        $num = sprintf('%.2f', $num);

        $user = User::findOne(['id' => $uid]);

        if(empty($user)) return [0, '用户不存在'];
        if( $num <= 0 ) return [0, '参数num必须大于0'];
        if( $num > $user['whitepoint'] ) return [0, '兑换余额不足'];

        //$dz_num  = sprintf('%.2f', $num * $rate );
        $rateStr = sprintf('%.5f', Func::getWhiteBalancePercent());

        $sxf_white_num = sprintf('%.2f', $num * $rate );
        $fact_white_num  = $num - $sxf_white_num;
        $dz_balance_num = sprintf('%.2f', $fact_white_num * Func::getWhiteBalancePercent());

        $data_1 = [
            'uid' => $uid,
            'trade_type' => WhitePoint::TRADE_TYPE_EXCHANGE_WHITE_BALANCE_SXF,
            'trade_num' => -$sxf_white_num,
            'trade_time' => time(),
            'trade_prenum' => $user->whitepoint,
            'trade_afternum' => $user->whitepoint - $sxf_white_num,
            'mark' => "白积分兑换美购券手续费（费率[{$rate}]）",
            'trade_no' => $trade_no,
            'other_uid' => 0,
            'other_type' => WhitePoint::OTHER_TYPE_SYSTEM,
            'other_name' => WhitePoint::label(WhitePoint::OTHER_TYPE_SYSTEM),
            'ymd' => date('Ymd'),
            'retype' => 0
        ];

        $data_2 = [
            'uid' => $uid,
            'trade_type' => WhitePoint::TRADE_TYPE_EXCHANGE_TO_BALANCE,
            'trade_num' => -$fact_white_num,
            'trade_time' => time(),
            'trade_prenum' => $user->whitepoint - $sxf_white_num,
            'trade_afternum' => $user->whitepoint - $num,
            'mark' => "白积分兑换美购券（倍率[{$rateStr}]）",
            'trade_no' => $trade_no,
            'other_uid' => $uid,
            'other_type' => WhitePoint::OTHER_TYPE_USER,
            'other_name' => $user->nickname,
            'ymd' => date('Ymd'),
            'retype' => 0
        ];
        $data_3 = [
            'uid' => $uid,
            'trade_type' => Order::TRADE_TYPE_EXCHANGE_FROM_WHITE,
            'trade_num' => $dz_balance_num,
            'trade_time' => time(),
            'trade_prenum' => $user->balance,
            'trade_afternum' => $user->balance + $dz_balance_num,
            'mark' => "白积分兑换美购券（倍率[{$rateStr}]）",
            'trade_no' => $trade_no,
            'other_uid' => $uid,
            'other_type' => Order::OTHER_TYPE_USER,
            'other_name' => $user->nickname,
            'ymd' => date('Ymd'),
            'retype' => 1
        ];
        $transaction = User::getDb()->beginTransaction();
        try {
            $user->whitepoint = $user->whitepoint - $num;
            $user->balance = $user->balance + $dz_balance_num;
            if(!$user->update())
                throw new Exception(array_values($user->getFirstErrors())[0]);

            $uwpd = new UserWhitepointDetail();
            $uwpd->setAttributes($data_1);
            if(!$uwpd->insert())
                throw new Exception(array_values($uwpd->getFirstErrors())[0]);

            $uwpd = new UserWhitepointDetail();
            $uwpd->setAttributes($data_2);
            if(!$uwpd->insert())
                throw new Exception(array_values($uwpd->getFirstErrors())[0]);

            $ubpd = new UserBalanceDetail();
            $ubpd->setAttributes($data_3);
            if(!$ubpd->insert())
                throw new Exception(array_values($ubpd->getFirstErrors())[0]);

            $transaction->commit();
            return [1, 'success'];
        } catch(\Exception $e) {
            $transaction->rollBack();
            //throw $e;
            return [0, $e->getMessage()];
        }

        return [0, 'fail'];

    }

    /**
     * @param $uid
     * @param $num
     * @param $rate 兑换手续费
     * @return array
     * @throws \Exception
     */
    public static function exchangeRedBalance($uid, $num, $rate){
        $trade_no = uniqid('ex') . rand(1000, 9999);
        $num = sprintf('%.2f', $num);

        $user = User::findOne(['id' => $uid]);

        if(empty($user)) return [0, '用户不存在'];
        if( $num <= 0 ) return [0, '参数num必须大于0'];
        if( $num > $user['redpoint'] ) return [0, '兑换余额不足'];

        $sxf_red_num = sprintf('%.2f', $num * $rate );
        $fact_red_num  = $num - $sxf_red_num;
        $dz_balance_num = sprintf('%.2f', $fact_red_num * Func::getRedBalancePercent());

        $data_1 = [
            'uid' => $uid,
            'trade_type' => RedPoint::TRADE_TYPE_EXCHANGE_RED_BALANCE_SXF,
            'trade_num' => -$sxf_red_num,
            'trade_time' => time(),
            'trade_prenum' => $user->redpoint,
            'trade_afternum' => $user->redpoint - $sxf_red_num,
            'mark' => "红积分兑换美购券手续费（费率[{$rate}]）",
            'trade_no' => $trade_no,
            'other_uid' => 0,
            'other_type' => RedPoint::OTHER_TYPE_SYSTEM,
            'other_name' => RedPoint::label(RedPoint::OTHER_TYPE_SYSTEM),
            'ymd' => date('Ymd'),
            'retype' => 0
        ];
        $data_2 = [
            'uid' => $uid,
            'trade_type' => RedPoint::TRADE_TYPE_EXCHANGE_RED_BALANCE,
            'trade_num' => -$fact_red_num,
            'trade_time' => time(),
            'trade_prenum' => $user->redpoint - $sxf_red_num,
            'trade_afternum' => $user->redpoint - $num,
            'mark' => "红积分兑换美购券（扣除手续费{$sxf_red_num}，费率[{$rate}]）",
            'trade_no' => $trade_no,
            'other_uid' => $uid,
            'other_type' => RedPoint::OTHER_TYPE_USER,
            'other_name' => $user->nickname,
            'ymd' => date('Ymd'),
            'retype' => 0
        ];


        $data_3 = [
            'uid' => $uid,
            'trade_type' => Order::TRADE_TYPE_EXCHANGE_FROM_RED,
            'trade_num' => $dz_balance_num,
            'trade_time' => time(),
            'trade_prenum' => $user->balance,
            'trade_afternum' => $user->balance + $dz_balance_num,
            'mark' => "红积分兑换美购券",
            'trade_no' => $trade_no,
            'other_uid' => $uid,
            'other_type' => Order::OTHER_TYPE_USER,
            'other_name' => $user->nickname,
            'ymd' => date('Ymd'),
            'retype' => 1
        ];
        $transaction = User::getDb()->beginTransaction();
        try {
            $user->redpoint = $user->redpoint - $num;
            $user->balance = $user->balance + $dz_balance_num;
            if(!$user->update())
                throw new Exception(array_values($user->getFirstErrors())[0]);

            $urpd = new UserRedpointDetail();
            $urpd->setAttributes($data_1);
            if(!$urpd->insert())
                throw new Exception(array_values($urpd->getFirstErrors())[0]);

            $urpd = new UserRedpointDetail();
            $urpd->setAttributes($data_2);
            if(!$urpd->insert())
                throw new Exception(array_values($urpd->getFirstErrors())[0]);

            $ubpd = new UserBalanceDetail();
            $ubpd->setAttributes($data_3);
            if(!$ubpd->insert())
                throw new Exception(array_values($ubpd->getFirstErrors())[0]);

            $transaction->commit();
            return [1, 'success'];
        } catch(\Exception $e) {
            $transaction->rollBack();
            //throw $e;
            return [0, $e->getMessage()];
        }

        return [0, 'fail'];

    }

    public static function withdraw($uid, $money, $sxf, $bankcardid){

        $money = sprintf('%.2f', $money);
        $sxf = sprintf('%.2f', $sxf);
        $user = User::findOne(['id' => $uid]);

        if(empty($user)) return [0, '用户不存在'];
        if( $money <= 0 ) return [0, '参数num必须大于0'];
        if( $money > $user->balance ) return [0, '兑换余额不足'];
        if( $money < $sxf ) return [0, '提现金额小于手续费'];

        $bankcard = UserBankcard::findOne(['id' => $bankcardid, 'uid' => $uid, 'status' => 1]);
        $bank = Func::param('bankcard', $bankcard['bankid']);
        if(empty($bankcard) || empty($bank)) return [0, '选择银行卡错误'];

        $userBalanceDetail = new UserBalanceDetail();
        $userWithdraw = new UserWithdraw();
        $trade_no = $userWithdraw->generateWithdrawSn();
        $data_1 = [
            'uid' => $uid,
            'trade_type' => Order::TRADE_TYPE_WITHDRAW,
            'trade_num' => -$money,
            'trade_time' => time(),
            'trade_prenum' => $user->balance,
            'trade_afternum' => $user->balance - $money,
            'mark' => "提现，手续费{$sxf}",
            'trade_no' => $trade_no,
            'other_uid' => $uid,
            'other_type' => Order::OTHER_TYPE_USER,
            'other_name' => $user->nickname,
            'ymd' => date('Ymd'),
            'retype' => 0
        ];
        $data_2 = [
            'withdraw_sn'       => $trade_no,
            'uid'               => $uid,
            'bankcardid'        => $bankcardid,
            'bankcity'          => $bankcard['bankcity'],
            'bankname'          => $bankcard['bankname'],
            'bankdeposit'       => $bankcard['bankdeposit'],
            'realname'          => $bankcard['realname'],
            'bankcardno'        => $bankcard['bankcardno'],
            'txamount'          => $money,
            'dzamount'          => $money-$sxf,
            'sxfamount'         => $sxf,
            'ymd'               => date('Ymd'),
            'created'           => time(),
            'status'            => 'created',
            'log'               => ''
        ];

        $transaction = User::getDb()->beginTransaction();
        try {
            $user->balance = $user->balance - $money;
            if(!$user->update())
                throw new Exception(array_values($user->getFirstErrors())[0]);

            $userBalanceDetail->setAttributes($data_1);
            if(!$userBalanceDetail->insert())
                throw new Exception(array_values($userBalanceDetail->getFirstErrors())[0]);

            $userWithdraw->setAttributes($data_2);
            if(!$userWithdraw->insert())
                throw new Exception(array_values($userWithdraw->getFirstErrors())[0]);

            $transaction->commit();

            SystemOperate::cash(
                Cashpool::TRADE_TYPE_WITHDRAW,
                -$money*100,
                $uid,
                "提现，手续费{$sxf}"
            );

            return [1, 'success'];
        } catch(\Exception $e) {
            $transaction->rollBack();
            return [0, $e->getMessage()];
        }

        return [0, 'fail'];
    }
}