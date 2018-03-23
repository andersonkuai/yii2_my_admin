<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/9/4
 * Time: 14:35
 */

namespace common\classes;


use common\enums\StockPoint;
use common\enums\WhitePoint;
use common\helpers\Func;
use common\models\Payment;
use common\models\UserRecharge;
use yii\base\Component;
use yii\base\InvalidParamException;

class PaymentSuccess extends Component
{
    public static function callback( $model ){

        if( !($model instanceof Payment) ) throw new InvalidParamException('PaymentSuccess::callback param 1 error! ');

        switch ($model->order_type){
            case 'FUND_RECHARGE':
                $userRecharge = UserRecharge::findOne(['recharge_sn' => $model->order_no]);
                if($userRecharge){
                    //标记充值成功
                    $userRecharge->setAttributes([
                        'platform' => $model->channel,
                        'order_sn' => $model->id,
                        'trade_status' => 'paid',
                        'time_paid'    => time()
                    ]);
                    $rtn = $userRecharge->save();

                    DelayTask::instance()->put('FUND_RECHARGE', ['recharge_sn' => $model->order_no]);

                    return $rtn;
                    /*
                    if( $rtn ){
                        $rate = Func::getReChargeStockRate();
                        $whiteRate = Func::getReChargeWhiteRate();
                        $num = $userRecharge->money * $rate;
                        //加库存积分
                        UserOperate::stockPoint([
                            'uid'       =>  $userRecharge->recharge_uid,
                            'trade_type'=>  StockPoint::TRADE_TYPE_CHARGE,
                            'num'       =>  $num,
                            'other_uid' =>  0,
                            'other_type'=>  StockPoint::OTHER_TYPE_SYSTEM,
                            'other_name'=>  StockPoint::label(StockPoint::OTHER_TYPE_SYSTEM),
                            'mark'      =>  "会员充值库存积分[{$rate}倍]",
                            'trade_no'  =>  $model->order_no
                        ]);
                        //加白积分
                        UserOperate::whitePoint([
                            'uid'       =>  $userRecharge->recharge_uid,
                            'trade_type'=>  WhitePoint::TRADE_TYPE_SELLER_CHARGE_GET,
                            'num'       =>  $userRecharge->money * $whiteRate,
                            'other_uid' =>  0,
                            'other_type'=>  WhitePoint::OTHER_TYPE_SYSTEM,
                            'other_name'=>  WhitePoint::label(WhitePoint::OTHER_TYPE_SYSTEM),
                            'mark'      =>  "会员充值返还白积分[{$whiteRate}倍]",
                            'trade_no'  =>  $model->order_no
                        ]);
                        //资金池记录
                        SystemOperate::cash(
                            StockPoint::TRADE_TYPE_CHARGE,
                            $userRecharge->money,
                            $userRecharge->recharge_uid,
                            "会员充值库存积分[{$rate}倍]"
                        );
                        //商家分成
                        UserOperate::sellerCommission($userRecharge->recharge_uid, $num, $model->order_no);
                        return true;
                    }
                    */
                }
            break;
        }

        return false;
    }
}