<?php
namespace common\models;

use Yii;
use yii\base\NotSupportedException;
use yii\db\ActiveRecord;
use yii\web\IdentityInterface;

/**
 * This is the model class for table "{{%user}}".
 *
 * @property integer $id
 * @property string $username
 * @property string $password
 * @property string $nickname
 * @property string $avatar
 * @property integer $membertype
 * @property string $mobile
 * @property string $email
 * @property string $realname
 * @property string $idnumber
 * @property integer $lastlogin_time
 * @property string $lastlogin_ip
 * @property string $usertoken
 * @property string $stockpoint
 * @property string $redpoint
 * @property string $whitepoint
 * @property string $balance
 * @property integer $status
 * @property integer $recommenderid
 * @property string $auth_key
 * @property integer $modified
 * @property integer $created
 * @property integer lastbalance_date
 * @property integer $editinitpwd
 * @property integer $level
 */
class User extends ActiveRecord implements IdentityInterface
{
    const STATUS_DELETED = 0;//代理商状态 禁用（删除）
    const STATUS_ACTIVE = 10;//解禁
    const ACTIVATED_YES = 1;//激活代理商
    const ACTIVATED_NO = 2;//取消激活状态


    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return '{{%user}}';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            ['status', 'default', 'value' => self::STATUS_ACTIVE],
            ['status', 'in', 'range' => [self::STATUS_ACTIVE, self::STATUS_DELETED]],
            [['membertype','level','is_activated', 'lastlogin_time', 'status', 'recommenderid', 'modified', 'created', 'lastbalance_date', 'ylmguid', 'editinitpwd'], 'integer'],
            [['stockpoint', 'redpoint', 'whitepoint', 'balance'], 'number'],
            [['username', 'nickname', 'lastlogin_ip'], 'string', 'max' => 50],
            [['password', 'avatar'], 'string', 'max' => 255],
            [['mobile', 'email', 'realname', 'idnumber', 'usertoken', 'auth_key'], 'string', 'max' => 100],
            //[['mobile'], 'unique', 'message' => '{attribute} "{value}" 已经存在！'],
            ['email', 'email'],
            ['recommenders', 'string']
        ];
    }
    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => '用户ID',
            'username' => '用户名',
            'password' => '密码',
            'nickname' => '昵称',
            'avatar' => '头像',
            'membertype' => '会员类型',
            'is_activated' => '是否激活',
            'level' => '代理商等级',
            'ylmguid' => '美购UID',
            'mobile' => '手机号',
            'email' => '邮箱',
            'realname' => '真实姓名',
            'idnumber' => '身份证号码',
            'lastlogin_time' => '最后登陆时间',
            'lastlogin_ip' => '最后登陆IP',
            'usertoken' => '登陆令牌，API请求中替代UID',
            'stockpoint' => '库存积分',
            'redpoint' => '红积分',
            'whitepoint' => '白积分',
            'balance'    => '余额',
            'status' => '用户状态',
            'recommenderid' => '推荐人ID',
            'recommenders'  => '多级推荐人',
            'auth_key' => 'Auth Key',
            'modified' => '编辑时间',
            'created' => '创建时间',
            'lastbalance_date' => '结算时间',
            'editinitpwd' => '是否修改初始密码'
        ];
    }
    /**
     * @inheritdoc
     */
    public static function findIdentity($id)
    {
        return static::findOne(['id' => $id, 'status' => self::STATUS_ACTIVE]);
    }

    /**
     * @inheritdoc
     */
    public static function findIdentityByAccessToken($token, $type = null)
    {
        return static::findOne(['usertoken' => $token, 'status' => self::STATUS_ACTIVE]);
    }

    /**
     * Finds user by username
     *
     * @param string $username
     * @return static|null
     */
    public static function findByUsername($username)
    {
        return static::findOne(['username' => $username, 'status' => self::STATUS_ACTIVE]);
    }

    /**
     * @inheritdoc
     */
    public function getId()
    {
        return $this->getPrimaryKey();
    }

    /**
     * @inheritdoc
     */
    public function getAuthKey()
    {
        return $this->auth_key;
    }

    /**
     * @inheritdoc
     */
    public function validateAuthKey($authKey)
    {
        return $this->getAuthKey() === $authKey;
    }

    /**
     * Validates password
     *
     * @param string $password password to validate
     * @return bool if password provided is valid for current user
     */
    public function validatePassword($password)
    {
        return Yii::$app->security->validatePassword($password, $this->password);
    }

    /**
     * Generates password hash from password and sets it to the model
     *
     * @param string $password
     */
    public function generatePasswordHash($password)
    {
        return Yii::$app->security->generatePasswordHash($password);
    }

    /**
     * Generates "remember me" authentication key
     */
    public function generateAuthKey()
    {
        return Yii::$app->security->generateRandomString();
    }

    public function generateUserToken(){

        return md5('ut' . uniqid() . rand(1000, 9999));
    }

    public static function getRecommenders( $pid, $depth ){

        $result = [];
		if($pid == 0 || $depth == 0) return $result;

        if( ($user = User::findOne($pid))){

            $arr = self::getRecommenders($user->recommenderid, $depth-1);
            
            $result = array_merge([$pid], $arr);
        }
        return $result;
    }

    public function registerByMobile($mobile, $rcmdid = 0, $ylmguid = 0){
        $mobile = strval($mobile);

        if( self::findOne(['mobile'=>$mobile]) ) return false;
        if( $ylmguid == 0 ) return false;

        $username = 'MG'. $ylmguid;
        $password = 'PW'.rand(10000, 99999);
        $data = [
            'username'      => $username,
            'auth_key'      => $this->generateAuthKey(),
            'password'      => $this->generatePasswordHash($password),
            'created'       => time(),
            'status'        => 10,
            'nickname'      => 'FD'.rand(10000, 99999),
            'realname'      => '',
            'ylmguid'       => $ylmguid,
            'mobile'        => $mobile,
            'membertype'    => 0,
            'email'         => '',
            'idnumber'      => '',
            'recommenderid' => $rcmdid,
            'recommenders'  => implode(',', self::getRecommenders($rcmdid, 10)),
            'avatar'        => '/avatar/avatar5.png',
            'modified'      => time(),
            'usertoken'     => $this->generateUserToken()
        ];

        $this->setAttributes($data);
        return $this->insert() ? true : false;
    }
}
