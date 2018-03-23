<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "hi_user_order_merge".
 *
 * @property integer $ID
 * @property string $OrderId
 * @property integer $Uid
 * @property string $Trade
 * @property double $Price
 * @property integer $RecvId
 * @property string $Message
 * @property integer $PayType
 * @property integer $Status
 * @property integer $SendStatus
 * @property integer $PayTime
 * @property integer $Time
 * @property string $PaymentInfo
 * @property integer $CourseId
 * @property double $OriginalPrice
 * @property double $DiscountPrice
 * @property integer $Count
 * @property integer $isMerge
 */
class HiUserOrderMerge extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'hi_user_order_merge';
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
            [['ID', 'OrderId', 'Uid', 'Time'], 'required'],
            [['ID', 'Uid', 'RecvId', 'PayType', 'Status', 'SendStatus', 'PayTime', 'Time', 'CourseId', 'Count', 'isMerge'], 'integer'],
            [['Price', 'OriginalPrice', 'DiscountPrice'], 'number'],
            [['Message', 'PaymentInfo'], 'string'],
            [['OrderId'], 'string', 'max' => 50],
            [['Trade'], 'string', 'max' => 255],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'ID' => 'ID',
            'OrderId' => '订单ID',
            'Uid' => '用户ID',
            'Trade' => '第三方交易单号',
            'Price' => '订单价格',
            'RecvId' => '收货地址ID',
            'Message' => '买家留言',
            'PayType' => '支付类型（0：未知1：微信2：支付宝）',
            'Status' => '订单状态（0:未支付1：已支付2：支付失败）',
            'SendStatus' => '发货状态(0:未发货1:已发货2:已签收）',
            'PayTime' => '订单支付时间',
            'Time' => '订单生成时间',
            'PaymentInfo' => '支付相关信息',
            'CourseId' => '课程ID',
            'OriginalPrice' => '购买时原价',
            'DiscountPrice' => '购买时折扣价',
            'Count' => '购买数量',
            'isMerge' => '是否合并，1：是，0：否',
        ];
    }
}
