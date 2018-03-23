<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/8/22
 * Time: 11:17
 */

namespace backend\models;


use common\models\DbModel;

class AuthItemChild extends DbModel
{
    protected function tableName()
    {
        return '{{%auth_item_child}}';
    }

    public function getChildren( $parentName = '' ){
        $trees = array();

        $rows = $this->findAll('1');
        foreach( $rows as $row ){
            $parent = $row['parent'];
            $child = $row['child'];

            $trees[$parent][] = $child;
        }

        return !empty($trees[$parentName]) ? $trees[$parentName] : $trees;
    }
}