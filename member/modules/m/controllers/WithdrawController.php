<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/11/2
 * Time: 16:01
 */

namespace member\modules\m\controllers;

use common\classes\UserOperate;
use common\helpers\Func;
use common\models\UserBankcard;
use Yii;
use common\models\UserWithdraw;
use member\modules\m\widgets\WithdrawListWidget;
use yii\data\Pagination;
use yii\web\Response;

class WithdrawController extends MobileBaseController
{
    public function actionList(){
        $date = trim(\Yii::$app->request->get('date', ''));
        $uid = Yii::$app->user->getId();
        $query = UserWithdraw::find();

        $query->where("uid={$uid}")->orderBy("created desc");
        if(!empty($date)) $query->andWhere(['ymd' => $date]);

        $pages = new Pagination(['totalCount' =>$query->count(), 'pageSize' => 10]);
        $withdrawList = $query->offset($pages->offset)->limit($pages->limit)->all();

        if( \Yii::$app->request->get('ajax') ){
            \Yii::$app->response->format = Response::FORMAT_JSON;
            return [
                'page'       => $pages->page,
                'rowCount'   => count($withdrawList),
                'totalCount' => $pages->totalCount,
                'pageCount'  => $pages->pageCount,
                'html'       => WithdrawListWidget::widget(['withdrawList' => $withdrawList]),
            ];
        }else{

            return $this->render('list', [
                'withdrawList' => $withdrawList,
                'date' => $date
            ]);
        }
    }

    public function actionIndex(){

        $uid = Yii::$app->user->getId();

        if( Yii::$app->request->getIsPost() ){
            if(Func::resubmit()) $this->exitJSON(0, '请勿重复提交');

            $bankcardid = intval(Yii::$app->request->post('bankcardid'));
            $money = trim(Yii::$app->request->post('money'));

            $bankcard = UserBankcard::findOne(['id' => $bankcardid, 'uid' => $uid, 'status' => 1]);
            $bank = Func::param('bankcard', $bankcard['bankid']);

            if(empty($bankcard) || empty($bank)) $this->exitJSON(0, '选择银行卡出错，请重试！');
            if($money < 5) $this->exitJSON(0, '提现金额最低为5元！');
            if($money > Yii::$app->user->identity->balance ) $this->exitJSON(0, '提现金额已超过余额！');

            $sxf = $money * 3/100;
            if( $sxf < 2 ) $sxf = 2.00;
            list($code, $msg) = UserOperate::withdraw($uid, $money, $sxf, $bankcardid);

            if($code == 1){
                $this->exitJSON(1, '操作成功！');
            }else{
                $this->exitJSON(0, $msg);
            }
        }else{
            $bankcardList = UserBankcard::findAll(['uid' => $uid, 'status' => 1]);
            return $this->render('index', ['bankcardList' => $bankcardList]);
        }

    }
    public function actionBankcard(){

        $list = UserBankcard::findAll(['uid' => Yii::$app->user->getId(), 'status' => 1]);

        return $this->render('bankcard', ['list' => $list]);
    }
    public function actionBankcardAdd(){

        if( Yii::$app->request->getIsPost() ){
            $realname = trim(Yii::$app->request->post('realname'));
            $identitycardno = trim(Yii::$app->request->post('identitycardno'));
            $bankid = intval(Yii::$app->request->post('bankid'));
            $bankname = trim(Yii::$app->request->post('bankname'));
            $bankcity = trim(Yii::$app->request->post('bankcity'));
            $bankdeposit = trim(Yii::$app->request->post('bankdeposit'));
            $bankcardno = trim(Yii::$app->request->post('bankcardno'));
            $mobile = trim(Yii::$app->request->post('mobile'));

            $bank = Func::param('bankcard', $bankid);
            if(empty($bank)) $this->exitJSON(0, '选择银行出错，请重试！');
            if(!Func::checkMobile($mobile)) $this->exitJSON(0, '手机号填写错误！');
            $data = [
                'uid'       => Yii::$app->user->getId(),
                'realname' => $realname,
                'identitycardno' => $identitycardno,
                'bankid' => $bankid,
                'bankname' => $bank['name'],
                'bankcity' => $bankcity,
                'bankdeposit' => $bankdeposit,
                'bankcardno' => $bankcardno,
                'mobile' => $mobile,
                'created'       => time(),
                'status'        => 1
            ];

            $model = new UserBankcard();
            $model->setAttributes  ($data);
            $rtn = $model->save();

            if( !$rtn ){
                $errors = $model->getFirstErrors();
                $this->exitJSON(0, array_shift($errors));
            }

            $this->exitJSON(1, '操作成功！');
        }else{
            return $this->render('bankcard-add');
        }
    }
    public function actionBankcardDelete(){
        $id = intval(\Yii::$app->request->get('id', 0));
        $uid = Yii::$app->user->getId();

        $bank = UserBankcard::findOne(['id' => $id, 'uid' => $uid]);

        if(!empty($bank)){
            $bank->status = 0;
            $bank->update();
            $this->exitJSON(1, '删除成功！');
        }else{
            $this->exitJSON(0, '删除失败！');
        }
    }
}