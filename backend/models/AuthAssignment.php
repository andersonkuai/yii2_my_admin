<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/8/23
 * Time: 14:56
 */

namespace backend\models;

use common\models\DbModel;
class AuthAssignment extends DbModel
{
    protected function tableName()
    {
        return '{{%auth_assignment}}';
    }

    public function getItemNames( $userId = 0 ){
        $trees = array();

        $rows = $this->findAll('1');
        foreach( $rows as $row ){
            $parent = $row['user_id'];
            $child = $row['item_name'];

            $trees[$parent][] = $child;
        }

        return !empty($trees[$userId]) ? $trees[$userId] : $trees;
    }
}