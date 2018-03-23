<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/8/22
 * Time: 10:31
 */

namespace backend\models;


use common\models\DbModel;

class AuthItem extends DbModel
{
    protected function tableName()
    {
        return '{{%auth_item}}';
    }

    public function getTree( $type = 0 ){

        $sql = "select a.*,b.parent from {{%auth_item}} a left join {{%auth_item_child}} b on a.name = b.child";
        $rows = $this->createCommand($sql)->queryAll();

        print_r($rows);
    }
}