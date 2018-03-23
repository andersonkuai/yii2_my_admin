<?php

namespace member\modules\m\controllers;

/**
 * Default controller for the `m` module
 */
class DefaultController extends MobileBaseController
{
    /**
     * Renders the index view for the module
     * @return string
     */
    public function actionIndex()
    {

        return $this->render('index');
    }

}
