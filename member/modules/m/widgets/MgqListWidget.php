<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/11/1
 * Time: 17:50
 */

namespace member\modules\m\widgets;


use yii\base\Widget;

class MgqListWidget extends Widget
{
    public $mgqList;

    public function run()
    {
        return $this->render('mgq-list', [
            'mgqList' => $this->mgqList
        ]);
    }
}