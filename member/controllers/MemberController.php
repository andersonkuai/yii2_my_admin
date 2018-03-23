<?php
namespace member\controllers;

use backend\models\Order;
use common\models\GlobalStatistics;
use common\models\UserConsume;
use Yii;
use yii\web\UploadedFile;
use yii\helpers\FileHelper;

class MemberController extends BaseController
{

    public function actionIndex(){
        $province = Yii::$app->user->getIdentity()->province;
        $city = Yii::$app->user->getIdentity()->city;
        $country = Yii::$app->user->getIdentity()->country;
        $where = !empty($country) ? array('province' => $province, 'city' => $city, 'area' => $country, 'pay_status' => 1) : array('province' => $province, 'city' => $city, 'pay_status' => 1);
        //今日订单
        $consume_count = Order::find()
            ->where($where)
            ->andWhere(['between', 'addtime', mktime(0,0,0,date('m'),date('d'),date('Y')),mktime(23,59,59,date('m'),date('d'),date('Y'))])
            ->count();
        $money = Order::find()
            ->where($where)
            ->andWhere(['between', 'addtime', mktime(0,0,0,date('m'),date('d'),date('Y')),mktime(23,59,59,date('m'),date('d'),date('Y'))])
            ->sum('money');
        //本月订单
        $month_consume_count = Order::find()
            ->where($where)
            ->andWhere(['between', 'addtime', mktime(0,0,0,date('m'),date('01'),date('Y')),mktime(23,59,59,date('m'),date('d'),date('Y'))])
            ->count();
        $month_money = Order::find()
            ->where($where)
            ->andWhere(['between', 'addtime', mktime(0,0,0,date('m'),date('01'),date('Y')),mktime(23,59,59,date('m'),date('d'),date('Y'))])
            ->sum('money');
        //总订单
        $total_consume_count = Order::find()
            ->where($where)
            ->count();
        $total_money = Order::find()
            ->where($where)
            ->sum('money');

        $renderData['consume_count'] = $consume_count;
        $renderData['money'] = !empty($money)?$money:0;
        $renderData['month_consume_count'] = $month_consume_count;
        $renderData['month_money'] = !empty($month_money)?$month_money:0;
        $renderData['total_consume_count'] = $total_consume_count;
        $renderData['total_money'] = !empty($total_money)?$total_money:0;
        return $this->display('index', $renderData);
    }

    public function actionPlupload()
    {
        $attach  = UploadedFile::getInstanceByName('file');
        if (empty($attach)) $this->exitJSON(0, 'No file upload!');
        if( $attach->size > 2*1024*1024) $this->exitJSON(0, '文件大小不能超过2M!');
        if( !in_array($attach->type,  array('image/jpeg', 'image/gif', 'image/jpg', 'image/png')) ){
            $this->exitJSON(0, '仅支持jpeg,gif,jpg,png格式图片!');
        }
        //$qiniu = new Qiniu ('js0gow');
        //$rtn = $qiniu->putFile ( $qiniu->getToken (), $attach->getTempName() );

        $fileName = '/image/'.date("Ymd").'/'.uniqid().'.'.$attach->getExtension();
        $filePath = Yii::getAlias('@static').$fileName;

        if (!is_dir( dirname($filePath) )) {
            FileHelper::createDirectory(dirname($filePath));
        }
        $rtn = $attach->saveAs($filePath);
        if( $rtn ){

            $this->exitJSON(1, 'success!', $fileName);
        }else{
            $this->exitJSON(0, 'Upload Fail!');
        }
    }
}