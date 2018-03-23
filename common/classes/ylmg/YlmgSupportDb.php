<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/11/6
 * Time: 16:42
 */

namespace common\classes\ylmg;

use common\helpers\Func;
use Yii;
use yii\base\Component;

class YlmgSupportDb extends Component implements YlmgSupportInterface
{

    public function isSeller($uid)
    {
        // TODO: Implement isSeller() method.

        if(!$uid) return false;

        $uname = 'mg'.$uid;
        $rtn = Yii::$app->wnmall
            ->createCommand("select seller_id from wn_seller_info where uname = '{$uname}' and is_on = 1")
            ->queryOne();

        return $rtn ? true : false;
    }

    public function register( $mobile, $tguid, $fund_uid ){
        $uid = 0;

        $password = 'PW'.rand(10000, 99999);
        $mgwww = 'http://www.yunlianmeigou.com';
        $head_image_num = array(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12);
        $head_index = array_rand($head_image_num);
        $rand_image_num = $head_image_num[$head_index];
        $user_data = array(
            'tel' => $mobile,
            'name' => '',
            'nickname' => $mobile,
            'pwd' => md5($password),
            'pwd_bak' => md5($password),
            'type' => 'unknown',
            'openid' => '',
            'unionid' => '',
            'ip' => Func::getClientIp(),
            'addtime' => time(),
            'updatetime' => time(),
            'headimgurl' => $mgwww . '/static/images/user_head/icon_' . $rand_image_num . '.png',
            'newheadimgurl' => $mgwww . '/static/images/user_head/icon_' . $rand_image_num . '.png',
            'img' => $mgwww . '/static/images/user_head/icon_' . $rand_image_num . '.png',
            'img_s' => $mgwww . '/static/images/user_head/icon_' . $rand_image_num . '.png',
            'img_m' => $mgwww . '/static/images/user_head/icon_' . $rand_image_num . '.png',
            'img_b' => $mgwww . '/static/images/user_head/icon_' . $rand_image_num . '.png',
            'tguid' => $tguid,
            'register2fund' => $fund_uid ? 1 : 0,
            'fund_uid' => $fund_uid,
        );

        $rtn = Yii::$app->wnmall->createCommand()->insert('wn_user', $user_data)->execute();

        if($rtn){
            $uid = Yii::$app->wnmall->getLastInsertID();
            Yii::$app->wnmall->createCommand()->update('wn_user', ['name' => 'mg' . $uid], "id={$uid}")->execute();

            $tg_record = Yii::$app->wnmall
                ->createCommand("select * from wn_user_tgcount where uid = {$tguid}")
                ->queryOne();
            if(empty($tg_record)){  //记录下用户锁粉数量+1
                Yii::$app->wnmall->createCommand()->insert('wn_user_tgcount', array('uid' => $tguid, 'tg_count' => 1))->execute();
            }else{
                $n_count = intval($tg_record['tg_count']) + 1;
                Yii::$app->wnmall->createCommand()->update('wn_user_tgcount', array('tg_count' => $n_count), "uid={$tguid}")->execute();
            }
        }
        return $uid;
    }

    public function getUserByMobile( $mobile ){
        $user = Yii::$app->wnmall
            ->createCommand("select * from wn_user where tel = '{$mobile}'")
            ->queryOne();

        return $user;
    }
    public function updateUser( $id, $data ){

        return Yii::$app->wnmall->createCommand()->update('wn_user', $data, "id={$id}")->execute();
    }
}