<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "hi_config".
 *
 * @property integer $ID
 * @property string $Field
 * @property string $Value
 * @property string $Mark
 */
class HiConfig extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'hi_config';
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
            [['Field'], 'string', 'max' => 30],
            [['Value', 'Mark'], 'string', 'max' => 255],
            [['Field'], 'unique'],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'ID' => 'ID',
            'Field' => '字段名',
            'Value' => '值',
            'Mark' => 'Mark',
        ];
    }
}
