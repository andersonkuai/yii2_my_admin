<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/9/18
 * Time: 16:27
 */

namespace common\classes;


use common\enums\AsyncTask;
use common\enums\Cashpool;
use common\enums\StockPoint;
use common\enums\WhitePoint;
use common\helpers\Func;
use common\models\UserConsume;
use common\models\UserRecharge;

class DelayTaskProcess
{
    const TASK_MAP = array(
        'CURRENT' => [ 'delayTime' => 0 ],//立刻执行
        'TEST' => [ 'delayTime' => 0 ],//立刻执行
        'FUND_RECHARGE' => [ 'delayTime' => 0 ],//立刻执行
        'USER_CONSUME' => [ 'delayTime' => 0 ],//立刻执行
    );

    public function run( $taskName, $taskData ){

        if( method_exists($this, $taskName) ){
            $str = "[".date("Y-m-d H:i:s")."][{$taskName}]"."[{$taskData}]";
            $rtn = $this->$taskName( $taskName, $taskData );
            $str.= "[".($rtn ? 1:0)."]".PHP_EOL;
            echo $str;
            return $rtn;
        }

        return false;
    }

    private function CURRENT( $taskName, $taskData ){


        return true;
    }
    private function TEST( $taskName, $taskData ){


        return true;
    }
    private function FUND_RECHARGE( $taskName, $taskData ){

        $data = json_decode($taskData, true);
        if(empty($data['recharge_sn'])) return false;
        $recharge_sn = $data['recharge_sn'];
        $rate = Func::getReChargeStockRate();
        $whiteRate = Func::getReChargeWhiteRate();

        $userRecharge = UserRecharge::findOne(['asynctask_status' => AsyncTask::STATUS_CREATED, 'recharge_sn' => $recharge_sn]);
        if(empty($userRecharge)) return false;

        //echo $userRecharge->recharge_sn . ' START...'.PHP_EOL;
        $rtns = $logs = [];
        $userRecharge->asynctask_status = AsyncTask::STATUS_PROGRESS;
        $userRecharge->update();

        $num = $userRecharge->money * $rate;
        //加库存积分
        $rtns[1] = UserOperate::stockPoint([
            'uid'       =>  $userRecharge->recharge_uid,
            'trade_type'=>  StockPoint::TRADE_TYPE_CHARGE,
            'num'       =>  $num,
            'other_uid' =>  0,
            'other_type'=>  StockPoint::OTHER_TYPE_SYSTEM,
            'other_name'=>  StockPoint::label(StockPoint::OTHER_TYPE_SYSTEM),
            'mark'      =>  "会员充值库存积分[{$rate}倍]",
            'trade_no'  =>  $userRecharge->recharge_sn
        ]);
        //加白积分
        $rtns[2] =UserOperate::whitePoint([
            'uid'       =>  $userRecharge->recharge_uid,
            'trade_type'=>  WhitePoint::TRADE_TYPE_SELLER_CHARGE_GET,
            'num'       =>  $userRecharge->money * $whiteRate,
            'other_uid' =>  0,
            'other_type'=>  WhitePoint::OTHER_TYPE_SYSTEM,
            'other_name'=>  WhitePoint::label(WhitePoint::OTHER_TYPE_SYSTEM),
            'mark'      =>  "会员充值返还白积分[{$whiteRate}倍]",
            'trade_no'  =>  $userRecharge->recharge_sn
        ]);
        //资金池记录
        $rtns[3] =SystemOperate::cash(
            Cashpool::TRADE_TYPE_CHARGE,
            $userRecharge->money,
            $userRecharge->recharge_uid,
            "会员充值库存积分[{$rate}倍][{$userRecharge->recharge_sn}]"
        );
        //商家分成 暂时关闭
        //$rtns[4] =UserOperate::sellerCommission($userRecharge->recharge_uid, $num, $userRecharge->recharge_sn);

        foreach($rtns as $key => $rtn){
            $logs[] = $key . '.'.implode(',', $rtn);
        }
        $userRecharge->asynctask_status = AsyncTask::STATUS_SUCCESS;
        $userRecharge->asynctask_log = $this->logs($logs);
        $userRecharge->update();

        //echo $userRecharge->recharge_sn . ' END.'.PHP_EOL;

        return true;
    }

    private function USER_CONSUME( $taskName, $taskData ){
        $data = json_decode($taskData, true);
        if(empty($data['consume_sn'])) return false;
        $consume_sn = $data['consume_sn'];

        $userConsume = UserConsume::findOne([
            'asynctask_status' => AsyncTask::STATUS_CREATED,
            'trade_status' => 0,
            'consume_sn' => $consume_sn
        ]);
        if(empty($userConsume)) return false;

        //echo $userConsume->consume_sn . ' START...'.PHP_EOL;
        $rtns = $logs = [];

        $userConsume->asynctask_status = AsyncTask::STATUS_PROGRESS;
        $userConsume->update();

        $num = sprintf('%.2f', $userConsume['point']);

        $rtns[1] = $rtnArr = UserOperate::consumePoint($userConsume['seller_uid'], $userConsume['consume_uid'],
            $num, $userConsume['consume_sn']);

        if(!$rtnArr[0]){
            $userConsume->asynctask_status = AsyncTask::STATUS_FAIL;
            $userConsume->asynctask_log = $this->logs($rtnArr[1]);
            $userConsume->update();
            return false;
        }
        $userConsume->trade_status = 1;
        $userConsume->update();
        //消费分成
        $rtns[2] = UserOperate::consumeCommission( $userConsume['consume_uid'], $num,
            $userConsume['consume_sn'] );

        foreach($rtns as $key => $rtn){
            $logs[] = $key . '.'.implode(',', $rtn);
        }

        $userConsume->asynctask_status = AsyncTask::STATUS_SUCCESS;
        $userConsume->asynctask_log = $this->logs($logs);
        $userConsume->update();
        //echo $userConsume->consume_sn . ' END.'.PHP_EOL;

        return true;
    }
    private function logs($logs){
        $arr = [];

        if( is_array($logs) ){
            $arr = $logs;
        }elseif(is_string($logs)){
            $arr[] = $logs;
        }

        array_unshift($arr, date("Y-m-d H:i:s"));
        return implode(PHP_EOL, $arr);
    }
}