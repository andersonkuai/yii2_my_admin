<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/10/23
 * Time: 16:13
 */

namespace member\modules\m\controllers;


use common\classes\ApiClient;
use common\classes\DelayTask;
use common\classes\UserOperate;
use common\enums\OrderType;
use common\helpers\Func;
use common\models\User;
use common\models\UserBalanceDetail;
use common\models\UserConsume;
use common\models\UserRecharge;
use common\models\UserRedpointDetail;
use common\models\UserStockpointDetail;
use common\models\UserWhitepointDetail;
use member\modules\m\widgets\MgqListWidget;
use yii\data\Pagination;
use yii\web\NotFoundHttpException;
use member\modules\m\widgets\PointListWidget;
use yii\web\Response;
use Yii;

class PointController extends MobileBaseController
{

    public function actionIndex(){
        $pointType = trim(\Yii::$app->request->get('type', 'white'));
        return $this->render('index', ['pointType' => $pointType]);
    }

    public function actionList(){

        $pointType = trim(\Yii::$app->request->get('type', 'white'));
        $retype = trim(\Yii::$app->request->get('retype'));
        $date = trim(\Yii::$app->request->get('date'));
        $uid = \Yii::$app->user->getId();
        if(!in_array($pointType, ['white', 'red', 'stock']))
            throw new NotFoundHttpException('参数type未找到!');
        if($pointType == 'white') $query = UserWhitepointDetail::find();
        if($pointType == 'red') $query = UserRedpointDetail::find();
        if($pointType == 'stock') $query = UserStockpointDetail::find();

        $query = $query->where("uid={$uid}")->orderBy("id desc,trade_time desc");

        if($retype === '0' || $retype === '1') $query->andWhere(['retype' => $retype]);
        if(!empty($date)) $query->andWhere(['ymd' => date('Ymd', strtotime($date))]);

        $pages = new Pagination(['totalCount' =>$query->count(), 'pageSize' => 10]);
        $pointList = $query->offset($pages->offset)->limit($pages->limit)->all();

        if( \Yii::$app->request->get('ajax') ){
            \Yii::$app->response->format = Response::FORMAT_JSON;
            return [
                'page'       => $pages->page,
                'rowCount'   => count($pointList),
                'totalCount' => $pages->totalCount,
                'pageCount'  => $pages->pageCount,
                'html'       => PointListWidget::widget(['pointType' => $pointType, 'pointList' => $pointList]),
            ];
        }else{
            return $this->render('list', ['pointType' => $pointType, 'pointList' => $pointList]);
        }
    }

    public function actionRecharge(){

        return $this->render('recharge');
    }

    public function actionRechargeNum(){

        $rechargeNum = Yii::$app->request->get('rechargeNum');
        if(!is_numeric($rechargeNum)) $this->exitJSON(0, '充值金额必须为数字！');
        $rechargeNum = floatval($rechargeNum);
        if($rechargeNum <= 0) $this->exitJSON(0, '充值金额必须大于零！');
        $rechargeNum = Func::trMoney($rechargeNum);

        $todayTotalNum = UserRecharge::getTodayTotalChargeNum(Yii::$app->user->getId());

        $limitChargeNum = Func::getReturnConfig('userchargelimit');
        if( Yii::$app->ylmgSupport->isSeller(Yii::$app->user->identity->ylmguid) ) $limitChargeNum = Func::getReturnConfig('sellerchargelimit');

        if( ($limitChargeNum * 100 - $todayTotalNum) < $rechargeNum)
            $this ->exitJSON(0, "充值金额已超出剩余额度，每日充值限额".number_format($limitChargeNum)."元，今天已充值".sprintf('%.2f', $todayTotalNum/100).'元');

        if($rechargeNum > 10000000) $this ->exitJSON(0, "超过单笔最大充值金额".number_format(100000)."元");
        $rechargePoint = sprintf('%.2f', $rechargeNum * Func::getReChargeStockRate());
        $this->exitJSON(1, '', ['rechargePoint' => $rechargePoint]);
    }
    public function actionExchangeNum(){

        $rechargeNum = Yii::$app->request->get('rechargeNum');
        if(!is_numeric($rechargeNum)) $this->exitJSON(0, '兑换数量必须为数字！');
        $rechargeNum = floatval($rechargeNum);
        if($rechargeNum <= 0) $this->exitJSON(0, '兑换数量必须大于零！');
        if($rechargeNum > Yii::$app->user->identity->redpoint) $this->exitJSON(0, '红积分余额不足！');
        //兑换手续费
        $rate = Func::getReturnConfig('red_stock_rates');
        $rechargePoint = sprintf('%.2f', $rechargeNum*(1-$rate) * Func::getReChargeStockRate());
        $this->exitJSON(1, '', ['rechargePoint' => $rechargePoint]);
    }

    public function actionExchangeBalanceNum(){

        $rechargeNum = Yii::$app->request->get('rechargeNum');
        if(!is_numeric($rechargeNum)) $this->exitJSON(0, '兑换数量必须为数字！');
        $rechargeNum = floatval($rechargeNum);
        if($rechargeNum < 1000) $this->exitJSON(0, '兑换数量必须大于1000！');
        if($rechargeNum > Yii::$app->user->identity->whitepoint) $this->exitJSON(0, '白积分余额不足！');
        //兑换费率
        $rate = Func::getWhiteBalanceRate();
        $balance = sprintf('%.2f', $rechargeNum*(1-$rate)* Func::getWhiteBalancePercent());
        $this->exitJSON(1, '', ['balance' => $balance]);
    }

    public function actionExchangeRedBalanceNum(){

        $rechargeNum = Yii::$app->request->get('rechargeNum');
        if(!is_numeric($rechargeNum)) $this->exitJSON(0, '兑换数量必须为数字！');
        $rechargeNum = floatval($rechargeNum);
        if($rechargeNum < 1000) $this->exitJSON(0, '兑换数量必须大于1000！');
        if($rechargeNum > Yii::$app->user->identity->redpoint) $this->exitJSON(0, '红积分余额不足！');
        //兑换费率
        $rate = Func::getRedBalanceRate();
        $balance = sprintf('%.2f', $rechargeNum*(1-$rate) * Func::getRedBalancePercent());
        $this->exitJSON(1, '', ['balance' => $balance]);
    }

    public function actionRechargeCreate(){
        $charge_money = Yii::$app->request->post("recharge_money");
        if(!is_numeric($charge_money)) $this->exitJSON(0, '充值金额必须为数字！');
        $charge_money = Func::trMoney($charge_money);
        if($charge_money <= 0){
            $this ->exitJSON(0, "请输入正确的充值金额");
        }
        $todayTotalNum = UserRecharge::getTodayTotalChargeNum(Yii::$app->user->getId());

        $limitChargeNum = Func::getReturnConfig('userchargelimit');
        if( Yii::$app->ylmgSupport->isSeller(Yii::$app->user->identity->ylmguid) ) $limitChargeNum = Func::getReturnConfig('sellerchargelimit');

        if( ($limitChargeNum * 100 - $todayTotalNum) < $charge_money)
            $this ->exitJSON(0, "充值金额已超出剩余额度，每日充值限额".number_format($limitChargeNum)."元，今天已充值".sprintf('%.2f', $todayTotalNum/100).'元');

        if($charge_money > 10000000) $this ->exitJSON(0, "超过单笔最大充值金额".number_format(100000)."元");
        $sys_app = Func::params("system.app");
        $appid = $sys_app[1001]['appid'];
        $re = new UserRecharge();
        $re->setAttributes([
            'appid' => $appid,
            'recharge_sn' => $re->generateRechargeSn(),
            'recharge_uid' => Yii::$app->user->getId(),
            'money' => $charge_money,
            'trade_status' => 'created',
            'created' => time(),
            'ymd'     => date('Ymd'),
            'time_paid' => 0,
        ]);
        if($re->save()){
            $this -> exitJSON(1, '创建成功', ['recharge_sn' => $re->recharge_sn]);
        }else{
            $err = $re -> getFirstErrors();
            $this -> exitJSON(0, array_shift($err));
        }
    }
    public function actionRechargePay(){
        $recharge_sn = Yii::$app->request->get("recharge_sn");
        $recharge = UserRecharge::findOne(["recharge_sn" => $recharge_sn]);
        if(empty($recharge)){$this -> exitJSON(0, "未知的充值记录");}
        if($recharge['trade_status'] !== "created"){$this -> exitJSON(0, "该订单不能支付");}
        $sys_app = Func::params("system.app");
        $secret = $sys_app[1001]['appsecret'];
        $appid = $sys_app[1001]['appid'];
        $params = [
            'appid' => $appid,
            'amount' => $recharge['money'],
            'order_type' => OrderType::FUND_RECHARGE,
            'order_no' => $recharge['recharge_sn'],
            'subject' => '用户充值库存积分',
            'body' => '用户充值库存积分',
            'description' => '用户充值库存积分',
        ];
        $ac = new ApiClient($appid, $secret);
        $result = $ac -> setData($params)->sign()->post("/v1/payments");
        $result = json_decode($result, true);
        if($result['code'] === 0){
            echo $result['msg'];
        }else{
            $payment_id = $result['data']['id'];
            $this->redirect(array('payment/index','id'=>$payment_id));
        }
    }
    //红积分兑换库存积分
    public function actionExchangeRedStock(){
        $user = Yii::$app->user->getIdentity()->getAttributes();
        if( Yii::$app->getRequest()->getIsPost() ){
            if(Func::resubmit()) $this->exitJSON(0, '请勿重复提交');

            $num = floatval(Yii::$app->getRequest()->post('num'));
            $rate = Func::getReturnConfig('red_stock_rates');
            if($num <= 0 ) $this->exitJSON(0, '兑换数量必须大于零');
            if($num > $user['redpoint']) $this->exitJSON(0, '兑换余额不足');
            $rtnArr = UserOperate::exchangeRedStock($user['id'], $num, $rate);

            if(!$rtnArr[0]) $this->exitJSON(0, '兑换失败！'.$rtnArr[1]);
            $this->exitJSON(1, '兑换成功');
        }else{

            $renderData = array('user' => $user);
            return $this->display('exchange-red-stock', $renderData);
        }
    }
    //白积分兑换美购券
    public function actionExchangeWhiteBalance(){
        $user = Yii::$app->user->getIdentity()->getAttributes();
        if( Yii::$app->getRequest()->getIsPost() ){
            if(Func::resubmit()) $this->exitJSON(0, '请勿重复提交');

            $num = floatval(Yii::$app->getRequest()->post('num'));
            $rate = Func::getWhiteBalanceRate();
            if($num < 1000 ) $this->exitJSON(0, '兑换数量必须大于1000');
            if($num > $user['whitepoint']) $this->exitJSON(0, '兑换余额不足');
            $rtnArr = UserOperate::exchangeWhiteBalance($user['id'], $num, $rate);

            if(!$rtnArr[0]) $this->exitJSON(0, '兑换失败！'.$rtnArr[1]);
            $this->exitJSON(1, '兑换成功');
        }else{

            $renderData = array('user' => $user);
            return $this->display('exchange-white-balance', $renderData);
        }
    }
    //红积分兑换美购券
    public function actionExchangeRedBalance(){
        $user = Yii::$app->user->getIdentity()->getAttributes();
        if( Yii::$app->getRequest()->getIsPost() ){
            if(Func::resubmit()) $this->exitJSON(0, '请勿重复提交');

            $num = floatval(Yii::$app->getRequest()->post('num'));
            $rate = Func::getRedBalanceRate();
            if($num < 1000 ) $this->exitJSON(0, '兑换数量必须大于1000');
            if($num > $user['redpoint']) $this->exitJSON(0, '兑换余额不足');
            $rtnArr = UserOperate::exchangeRedBalance($user['id'], $num, $rate);

            if(!$rtnArr[0]) $this->exitJSON(0, '兑换失败！'.$rtnArr[1]);
            $this->exitJSON(1, '兑换成功');
        }else{

            $renderData = array('user' => $user);
            return $this->display('exchange-red-balance', $renderData);
        }
    }
    public function actionConsumeAdd(){
        if( Yii::$app->getRequest()->getIsPost() ){
            if(Func::resubmit()) $this->exitJSON(0, '请勿重复提交');

            $mguidOrMobile = trim(Yii::$app->getRequest()->post('mguid'));
            $money = floatval(Yii::$app->getRequest()->post('money'));
            if( $money < 9.9 ) $this->exitJSON(0, '收银金额最低9.9元！');
            $platform = 1;
            $order_sn = uniqid('sy').rand(1000, 9999);
            $seller = Yii::$app->user->getIdentity();
            if(empty($mguidOrMobile)) $this->exitJSON(0, '会员UID/手机号不能为空！');
            if( $seller['stockpoint'] < Func::trMoney($money) ) $this->exitJSON(0, '库存积分不足！');

            $autoRegister = 0;//标记是否自动注册
            if( Func::checkMobile($mguidOrMobile) ){

                $mgUser = Yii::$app->ylmgSupport->getUserByMobile($mguidOrMobile);
                if(empty($mgUser)){
                    $ylmguid = Yii::$app->ylmgSupport->register( $mguidOrMobile, $seller->ylmguid, 0 );
                    if(!$ylmguid) $this->exitJSON(0, '操作失败，Error code 001');
                    //注册成功之后 注册fund
                    $consume = new User();
                    $rtn = $consume->registerByMobile($mguidOrMobile, $seller->id, $ylmguid);
                    if(!$rtn) $this->exitJSON(0, '操作失败，Error code 001');
                    Yii::$app->ylmgSupport->updateUser($ylmguid, [
                        'register2fund' => 1,
                        'fund_uid' => $consume->id
                    ]);
                    $autoRegister = 1;
                }else{
                    $consume = User::findOne(['ylmguid' => $mgUser['id']]);
                }
            }else{
                $consume = User::findOne(['ylmguid' => intval($mguidOrMobile)]);
            }

            if(empty($consume)) $this->exitJSON(0, '系统繁忙，请稍后再试！');//会员UID/手机号不存在
            if( $consume['id'] == $seller['id'] ) $this->exitJSON(0, '会员UID/手机号不能是自己！');
            if( !in_array( $platform, array_keys( Func::params('user_consume.platform') ) ))
                $this->exitJSON(0, '不支持该平台！');
            if(empty($order_sn)) $this->exitJSON(0, '来源订单号不能为空！');

            $sys_app = Func::params("system.app");
            $appid = $sys_app[1001]['appid'];
            $model = new UserConsume();
            $data = [
                'consume_sn' => $model->generateConsumeSn(),
                'appid'       => $appid,
                'consume_uid' => $consume['id'],
                'money' => Func::trMoney($money),
                'point' => Func::trMoney($money),
                'seller_uid' => $seller['id'],
                'platform' => $platform,
                'order_sn' => $order_sn,
                'trade_status' => $autoRegister == 0 ? 0 : 6,
                'created' => time()
            ];
            //if( $seller['stockpoint'] < $data['money'] ) $this->exitJSON(0, '库存积分不足！');
            $model->setAttributes  ($data);
            $rtn = $model->save();

            if( !$rtn ){
                $errors = $model->getFirstErrors();
                $this->exitJSON(0, array_shift($errors));
            }
            if($autoRegister == 0) DelayTask::instance()->put('USER_CONSUME', ['consume_sn' => $model->consume_sn]);
            $this->exitJSON(1, '收银成功!');
        }else{

            return $this->display('consume-add');
        }
    }

    public function actionMgq(){
        //今日收入
        $todayIncome = UserBalanceDetail::find()
            ->where(['uid' => Yii::$app->user->getId(), 'retype' => 1, 'ymd' => date('Ymd')])
            ->sum('trade_num');
        //本月收入
        $monthIncome = UserBalanceDetail::find()
            ->where(['uid' => Yii::$app->user->getId(), 'retype' => 1])
            ->andWhere("date_format(ymd, '%Y%m') = " . date("Ym"))
            ->sum('trade_num');

        return $this->display('mgq', [
            'todayIncome' => $todayIncome ? sprintf('%.2f',$todayIncome) : '0.00',
            'monthIncome' => $monthIncome ? sprintf('%.2f',$monthIncome) : '0.00'
        ]);
    }

    public function actionMgqList(){
        $date = trim(\Yii::$app->request->get('date', ''));
        $uid = Yii::$app->user->getId();
        $query = UserBalanceDetail::find();

        $query->where("uid={$uid}")->orderBy("id desc,trade_time desc");
        if(!empty($date)) $query->andWhere("date_format(ymd, '%Y%m') = " . $date);

        $pages = new Pagination(['totalCount' =>$query->count(), 'pageSize' => 10]);
        $mgqList = $query->offset($pages->offset)->limit($pages->limit)->all();

        if( \Yii::$app->request->get('ajax') ){
            \Yii::$app->response->format = Response::FORMAT_JSON;
            return [
                'page'       => $pages->page,
                'rowCount'   => count($mgqList),
                'totalCount' => $pages->totalCount,
                'pageCount'  => $pages->pageCount,
                'html'       => MgqListWidget::widget(['mgqList' => $mgqList]),
            ];
        }else{
            $totalIncome = UserBalanceDetail::find()
                ->where(['uid' => $uid, 'retype' => 1])
                ->sum('trade_num');
            return $this->render('mgq-list', [
                'mgqList' => $mgqList,
                'date' => $date,
                'totalIncome' => $totalIncome ? sprintf('%.2f', $totalIncome) : '0.00'
            ]);
        }
    }
}