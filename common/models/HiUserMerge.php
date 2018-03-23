<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "hi_user_merge".
 *
 * @property integer $Uid
 * @property string $UserName
 * @property string $Mobile
 * @property integer $Type
 * @property integer $Time
 * @property string $EnName
 * @property string $NickName
 * @property string $UserStatus
 * @property integer $Birthday
 * @property integer $SurveyScore
 * @property integer $SurveyTime
 * @property string $City
 * @property integer $CityId
 * @property string $ReadLevel
 */
class HiUserMerge extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'hi_user_merge';
    }

    /**
     * @return \yii\db\Connection the database connection used by this AR class.
     */
    public static function getDb()
    {
        return Yii::$app->get('hiread');
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['Uid'], 'required'],
            [['Uid', 'Type', 'Time', 'Birthday', 'SurveyScore', 'SurveyTime', 'CityId'], 'integer'],
            [['UserName'], 'string', 'max' => 50],
            [['Mobile'], 'string', 'max' => 11],
            [['EnName', 'UserStatus'], 'string', 'max' => 20],
            [['NickName'], 'string', 'max' => 100],
            [['City'], 'string', 'max' => 60],
            [['ReadLevel'], 'string', 'max' => 255],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'Uid' => '玩家ID',
            'UserName' => '用户名',
            'Mobile' => '绑定手机号',
            'Type' => '用户类型(1:普通用户2:微信用户)',
            'Time' => '注册时间',
            'EnName' => '英文名',
            'NickName' => '昵称',
            'UserStatus' => '用户状态，regist：注册用户，try：试听用户，charge：付费用户',
            'Birthday' => '生日',
            'SurveyScore' => '问卷调查分数',
            'SurveyTime' => '问卷调查时间',
            'City' => '城市名称',
            'CityId' => '城市id',
            'ReadLevel' => '水平测试等级',
        ];
    }
}
