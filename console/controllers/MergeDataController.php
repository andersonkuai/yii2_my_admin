<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/11/3
 * Time: 11:12
 */

namespace console\controllers;

use common\models\HiConfig;
use yii\console\Controller;
use yii\db\Exception;

class MergeDataController extends Controller
{
    /**
     * 合并订单数据
     * 基本信息
     */
    public function actionOrders(){
        //获取订单数据
        for ($i = 0; $i <= 9; $i++){
            $tableName = 'hi_user_order_'.$i;
            $connection = \Yii::$app->hiread;
            $sql = "INSERT INTO hi_user_order_merge(`ID`,`Uid`,`OrderId`,`Trade`,`Price`,`RecvId`,`Message`,`PayType`,`Status`,`SendStatus`,`PayTime`,`Time`,`PaymentInfo`) 
                    select `ID`,`Uid`,`OrderId`,`Trade`,`Price`,`RecvId`,`Message`,`PayType`,`Status`,`SendStatus`,`PayTime`,`Time`,`PaymentInfo` 
                    from {$tableName} where isMerge = 0 
                    ON DUPLICATE KEY UPDATE 
                    `ID`= values(ID),`Uid`= values(Uid),OrderId = VALUES(OrderId),Trade = VALUES(Trade),Price = VALUES(Price),`RecvId` = VALUES(`RecvId`),`Message` = VALUES(`Message`),
                    `PayType` = VALUES(`PayType`),`Status` = VALUES(`Status`),`SendStatus` = VALUES(`SendStatus`),`PayTime` = VALUES(`PayTime`),`Time` = VALUES(`Time`),`PaymentInfo` = VALUES(`PaymentInfo`);";
            $result1 = $connection->createCommand($sql)->execute();
            //变更记录
            $sql = "update {$tableName} set isMerge = 1 where isMerge = 0;";
            $result2 = $connection->createCommand($sql)->execute();
            echo 'replace:'.$result1.',update:'.$result2.'--';
        }//end for
    }
    /**
     * 合并订单数据
     * 详情
     */
    public function actionOrdersDetail(){
        //获取订单数据
        for ($i = 0; $i <= 9; $i++){
            $tableName1 = 'hi_user_order_detail_'.$i;
            $tableName2 = 'hi_user_order_'.$i;
            $connection = \Yii::$app->hiread;
            $sql = "INSERT INTO hi_user_order_merge(`Uid`,`OrderId`,`CourseId`,`OriginalPrice`,`DiscountPrice`,`Count`) select a.`Uid`,b.`OrderId`,a.`CourseId`,a.`Price`,a.`DiscountPrice`,a.`Count` 
                    from {$tableName1} a INNER JOIN {$tableName2} b ON a.Oid = b.ID where a.isMerge = 0 ON DUPLICATE KEY UPDATE `Uid`= values(Uid),`OrderId`= values(OrderId),CourseId = VALUES(CourseId),OriginalPrice = VALUES(OriginalPrice),DiscountPrice = VALUES(DiscountPrice),`Count` = VALUES(`Count`);";
            $result1 = $connection->createCommand($sql)->execute();
            //修改用户状态
            $sql = "select a.`Uid`,a.`IsTry` from {$tableName1} a INNER JOIN {$tableName2} b ON a.Oid = b.ID where b.Status = 1";
            $orders = $connection->createCommand($sql)->queryAll();
            if (!empty($orders)){
                foreach ($orders as $val){
                    $state = $val["IsTry"] == 1 ? "try" : "charge" ;
                    //查询用户数据
                    $user = $connection->createCommand("select UserStatus from hi_user_merge where Uid = {$val['Uid']}")->queryOne();
                    if(empty($user)){
                        //插入数据
                        $connection->createCommand("insert into hi_user_merge(`Uid`,`UserStatus`) VALUES ('{$val["Uid"]}','{$state}')")->execute();
                    }else{
                        if(($user["UserStatus"] == 'try' && $state == 'charge') || ($user['UserStatus'] == 'regist' && $state == 'try')){
                            //更新数据
                            $connection->createCommand("update hi_user_merge set `UserStatus` = '{$state}' where Uid = {$val['Uid']} ")->execute();
                        }
                    }//end if
                }//end foreach
            }
            //变更记录
            $sql = "update {$tableName1} set isMerge = 1 where isMerge = 0;";
            $result2 = $connection->createCommand($sql)->execute();
            echo 'replace:'.$result1.',update:'.$result2.'--';
        }//end for
    }
    /**
     * 合并用户数据
     * uid，注册账号，联系电话，注册时间
     */
    public function actionUsers1(){
        $userSuffix = [0,1,2,3,4,5,6,7,8,9,'a','b','c','d','e','f'];
        //获取用户数据
        foreach ($userSuffix as $v){
            $tableName = 'hi_user_'.$v;
            $connection = \Yii::$app->hiread;
            $sql = "INSERT INTO hi_user_merge(`Uid`,`UserName`,`Mobile`,`Time`,`Channel`) select `Uid`,`UserName`,`Mobile`,`Time`,`Channel` 
                    from {$tableName} where isMerge = 0 ON DUPLICATE KEY UPDATE `Uid`= values(Uid),`UserName`= values(UserName),Mobile = VALUES(Mobile),`Time` = VALUES(`Time`),`Channel` = VALUES(`Channel`) ;";
//            $sql = "replace into hi_user_merge(`Uid`,`UserName`,`Mobile`,`Time`) select `Uid`,`UserName`,`Mobile`,`Time` from {$tableName} where isMerge = 0";
            $result1 = $connection->createCommand($sql)->execute();
            //变更记录
            $sql = "update {$tableName} set isMerge = 1 where isMerge = 0;";
            $result2 = $connection->createCommand($sql)->execute();
            echo 'replace:'.$result1.',update:'.$result2.'--';
        }//end for
    }
    /**
     * 合并用户数据
     * 学员姓名（英文名），生日，调查问卷得分，调查问卷时间，水平测试等级，昵称
     */
    public function actionUsers2(){
        $userSuffix = [0,1,2,3,4,5,6,7,8,9];
        //获取用户数据
        foreach ($userSuffix as $v){
            $tableName = 'hi_user_info_'.$v;
            $connection = \Yii::$app->hiread;
            $sql = "select `Uid`,`EnName`,`Birthday`,`SurveyScore`,`SurveyTime`,`NickName` from {$tableName} WHERE isMerge = 0";
            $result1 = $connection->createCommand($sql)->queryAll();
            if(!empty($result1)){
                $value = '';
                //获取水平测试配置
                $selectReadLevel = HiConfig::find()->select(['Value'])->where(['Field' => 'SelectReadLevel'])->asArray()->one();
                foreach ($result1 as $val){
                    $level = 0;
                    if(!empty($selectReadLevel)){
                        $config = json_decode($selectReadLevel['Value'],true);
                        foreach($config as $key =>$v){
                            if($val['SurveyScore']<=$key){
                                $level = $v;
                                break;
                            }
                        }
                    }
                    $value .= "('{$val['Uid']}','{$val['EnName']}','{$val['Birthday']}','{$val['SurveyScore']}','{$val['SurveyTime']}','{$level}','{$val['NickName']}'),";
                }//end foreach
                $value = rtrim($value,',');
                $sql = "INSERT INTO `hi_user_merge` (`Uid`,`EnName`,`Birthday`,`SurveyScore`,`SurveyTime`,`ReadLevel`,`NickName`) VALUES {$value} 
                        ON DUPLICATE KEY UPDATE `Uid`= values(Uid),`EnName`= values(EnName),Birthday = VALUES(Birthday),SurveyScore = VALUES(SurveyScore),`SurveyTime` = VALUES(`SurveyTime`),`ReadLevel` = VALUES(`ReadLevel`),`NickName` = VALUES(`NickName`) ;";
                try{
                    $result2 = $connection->createCommand($sql)->execute();
                    //变更记录
                    $sql = "update {$tableName} set isMerge = 1 where isMerge = 0;";
                    $result3 = $connection->createCommand($sql)->execute();
                    echo 'replace:'.$result2.',update:'.$result3.'--';
                }catch (Exception $e){
                    echo $e->getMessage();
                }
            }//end if
        }//end for
    }
    /**
     * 合并用户数据
     * 省级地址，孩子性别
     */
    public function actionUsers3(){
        $userSuffix = [0,1,2,3,4,5,6,7,8,9];
        //获取用户数据
        foreach ($userSuffix as $v){
            $tableName = 'hi_user_survey_'.$v;
            $connection = \Yii::$app->hiread;
            $sql = "INSERT INTO hi_user_merge(`Uid`,`City`,`CityId`,`Gender`) select `Uid`,`Province`,`ProvinceId`,`Gender` 
                    from {$tableName} where isMerge = 0 ON DUPLICATE KEY UPDATE `Uid`= values(Uid),`City`= values(City),CityId = VALUES(CityId),Gender = VALUES(Gender);";
//            $sql = "replace into hi_user_merge(`Uid`,`EnName`,`Birthday`,`SurveyScore`,`SurveyTime`) select `Uid`,`EnName`,`Birthday`,`SurveyScore`,`SurveyTime` from {$tableName} where isMerge = 0";
            $result1 = $connection->createCommand($sql)->execute();
            //变更记录
            $sql = "update {$tableName} set isMerge = 1 where isMerge = 0;";
            $result2 = $connection->createCommand($sql)->execute();
            echo 'replace:'.$result1.',update:'.$result2.'--';
        }//end for
    }
    /**
     * 合并用户地址数据
     */
    public function actionAddress(){
        $userSuffix = [0,1,2,3,4,5,6,7,8,9];
        foreach ($userSuffix as $v){
            $tableName = 'hi_user_address_'.$v;
            $connection = \Yii::$app->hiread;
            $sql = "replace into hi_user_address_merge select * from {$tableName} where isMerge = 0";
            $result1 = $connection->createCommand($sql)->execute();
            //变更记录
            $sql = "update {$tableName} set isMerge = 1 where isMerge = 0;";
            $result2 = $connection->createCommand($sql)->execute();
            echo 'replace:'.$result1.',update:'.$result2.'--';
        }//end foreach
    }

}