<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/8/16
 * Time: 14:07
 */

namespace common\models;

use Yii;
use yii\base\InvalidParamException;
use yii\db\Query;
class DbModel
{
    protected function tableName()
    {
        return '{{%' . Inflector::camel2id(StringHelper::basename(get_called_class()), '_') . '}}';
    }
    /*
     * @param array $conditions yii\db\Query property
     * keys [where,limit,offset,orderBy,indexBy,select,selectOption,distinct,from,groupBy,join,having,union,params]
     *
     * @return yii\db\Query Object
     */
    public function find( array $conditions ){

        return new Query($conditions);
    }
    //@param array|string $conditions
    public function findRow( $conditions ){

        if( is_array($conditions) ){
            $conditions['from'] = [$this->tableName()];
            $conditions['limit'] = 1;
            return $this->find($conditions)->one();
        }elseif( is_string( $conditions ) ){
            return $this->find(array(
                'from' => [$this->tableName()],
                'where' => $conditions,
                'limit' => 1
            ))->one();
        }else{
            throw new InvalidParamException("Param Error!");
        }
    }
    //@param array|string $conditions
    public function findAll( $conditions ){
        if( is_array($conditions) ){
            $conditions['from'] = [$this->tableName()];
            return $this->find($conditions)->all();
        }elseif( is_string( $conditions ) ){
            return $this->find(array(
                'from' => [$this->tableName()],
                'where' => $conditions
            ))->all();
        }else{
            throw new InvalidParamException("Param Error!");
        }
    }
    public function count( $where ){

        return $this->find(array(
            'from' => [$this->tableName()],
            'where' => $where
        ))->count();
    }

    public function insert( $data, $tableName = null ){

        if( $tableName === null ) $tableName = $this->tableName();

        $rtn = Yii::$app->db->createCommand()->insert($tableName, $data)->execute();
        $lastid = Yii::$app->db->getLastInsertID();
        return $lastid ? $lastid : $rtn;
    }

    public function update( $data, $where, $tableName = null ){

        if( $tableName === null ) $tableName = $this->tableName();

        return Yii::$app->db->createCommand()->update($tableName, $data, $where)->execute();
    }

    public function delete( $where, $tableName = null ){

        if( $tableName === null ) $tableName = $this->tableName();

        return Yii::$app->db->createCommand()->delete($tableName, $where)->execute();
    }

    public static function createCommand( $sql ){

        return Yii::$app->db->createCommand( $sql );
    }
}