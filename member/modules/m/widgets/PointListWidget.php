<?php

namespace member\modules\m\widgets;

use yii\base\Widget;

class PointListWidget extends Widget
{
    public $pointType;
    public $pointList;

    public function run()
    {
        return $this->render('point-list', [
            'pointType' => $this->pointType,
            'pointList' => $this->pointList
        ]);
    }
}