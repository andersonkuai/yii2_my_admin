<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/11/2
 * Time: 16:11
 */

namespace member\modules\m\widgets;


use yii\base\Widget;

class WithdrawListWidget extends Widget
{
    public $withdrawList;

    public function run()
    {
        return $this->render('withdraw-list', [
            'withdrawList' => $this->withdrawList
        ]);
    }
}