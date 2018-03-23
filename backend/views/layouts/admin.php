<?php
use yii\helpers\Html;
use member\helpers\Utility;
?>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title><?=\Yii::t('app',Html::encode($this->title))?></title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="/adminlte/bower_components/bootstrap/dist/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="/adminlte/bower_components/font-awesome/css/font-awesome.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="/adminlte/bower_components/Ionicons/css/ionicons.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="/adminlte/dist/css/AdminLTE.min.css">
    <!-- AdminLTE Skins. We have chosen the skin-blue for this starter
          page. However, you can choose any other skin. Make sure you
          apply the skin class to the body tag so the changes take effect. -->
    <link rel="stylesheet" href="/adminlte/dist/css/skins/skin-blue.min.css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <!-- jQuery 3 -->
    <script src="/adminlte/bower_components/jquery/dist/jquery.min.js"></script>
    <script type="text/javascript">
        var CSRF = <?php echo json_encode(['name' => Yii::$app->request->csrfParam,'value' => Yii::$app->request->getCsrfToken()])?>
    </script>
    <style type="text/css">
        /*.nav>li.messages-menu,.nav>li.notifications-menu,.nav>li.tasks-menu,.nav>li:last-child{display: none;}*/
        .posi {
            display: none;
            position: fixed;
            width: 100%;
            height: 100%;
            top: 0px;
            z-index: 10;
            background: rgba(10, 10, 10, 0.65);
            text-align: center;
        }

        .posi-img {
            width: 6%;
            margin: 18% 20px 10px 0px;
        }
    </style>
</head>
<!--
BODY TAG OPTIONS:
=================
Apply one or more of the following classes to get the
desired effect
|---------------------------------------------------------|
| SKINS         | skin-blue                               |
|               | skin-black                              |
|               | skin-purple                             |
|               | skin-yellow                             |
|               | skin-red                                |
|               | skin-green                              |
|---------------------------------------------------------|
|LAYOUT OPTIONS | fixed                                   |
|               | layout-boxed                            |
|               | layout-top-nav                          |
|               | sidebar-collapse                        |
|               | sidebar-mini                            |
|---------------------------------------------------------|
-->
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">

    <!-- Main Header -->
    <header class="main-header">

        <!-- Logo -->
        <a href="/" class="logo">
            <!-- mini logo for sidebar mini 50x50 pixels -->
            <span class="logo-mini"><b><?=Yii::$app->params['hi-read']?></b></span>
            <!-- logo for regular state and mobile devices -->
            <span class="logo-lg"><b><?=Yii::$app->params['hi-read']?></b></span>
        </a>

        <!-- Header Navbar -->
        <nav class="navbar navbar-static-top" role="navigation">
            <!-- Sidebar toggle button-->
            <a href="#" class="sidebar-toggle" data-toggle="push-menu" role="button">
                <span class="sr-only">Toggle navigation</span>
            </a>
            <!-- Navbar Right Menu -->
            <div class="navbar-custom-menu">
                <ul class="nav navbar-nav">
                    <!-- Messages: style can be found in dropdown.less-->
<!--                    <li class="dropdown messages-menu">-->
<!--                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">-->
<!--                            <i class="fa fa-envelope-o"></i>-->
<!--                            <span class="label label-success">4</span>-->
<!--                        </a>-->
<!--                        <ul class="dropdown-menu">-->
<!--                            <li class="header">You have 4 messages</li>-->
<!--                            <li>-->
<!--                                <ul class="menu">-->
<!--                                    <li>-->
<!--                                        <a href="#">-->
<!--                                            <div class="pull-left">-->
<!--                                                <img src="/adminlte/dist/img/user2-160x160.jpg" class="img-circle" alt="User Image">-->
<!--                                            </div>-->
<!--                                            <h4>-->
<!--                                                Support Team-->
<!--                                                <small><i class="fa fa-clock-o"></i> 5 mins</small>-->
<!--                                            </h4>-->
<!--                                            <p>Why not buy a new awesome theme?</p>-->
<!--                                        </a>-->
<!--                                    </li>-->
<!--                                </ul>-->
<!--                            </li>-->
<!--                            <li class="footer"><a href="#">See All Messages</a></li>-->
<!--                        </ul>-->
<!--                    </li>-->
                    <!-- /.messages-menu -->

                    <!-- Notifications Menu -->
<!--                    <li class="dropdown notifications-menu">-->
<!--                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">-->
<!--                            <i class="fa fa-bell-o"></i>-->
<!--                            <span class="label label-warning">10</span>-->
<!--                        </a>-->
<!--                        <ul class="dropdown-menu">-->
<!--                            <li class="header">You have 10 notifications</li>-->
<!--                            <li>-->
<!--                                <ul class="menu">-->
<!--                                    <li>-->
<!--                                        <a href="#">-->
<!--                                            <i class="fa fa-users text-aqua"></i> 5 new members joined today-->
<!--                                        </a>-->
<!--                                    </li>-->
<!--                                </ul>-->
<!--                            </li>-->
<!--                            <li class="footer"><a href="#">View all</a></li>-->
<!--                        </ul>-->
<!--                    </li>-->
                    <!-- Tasks Menu -->
<!--                    <li class="dropdown tasks-menu">-->
<!--                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">-->
<!--                            <i class="fa fa-flag-o"></i>-->
<!--                            <span class="label label-danger">9</span>-->
<!--                        </a>-->
<!--                        <ul class="dropdown-menu">-->
<!--                            <li class="header">You have 9 tasks</li>-->
<!--                            <li>-->
<!--                                <ul class="menu">-->
<!--                                    <li>-->
<!--                                        <a href="#">-->
<!--                                            <h3>-->
<!--                                                Design some buttons-->
<!--                                                <small class="pull-right">20%</small>-->
<!--                                            </h3>-->
<!--                                            <div class="progress xs">-->
<!--                                                <div class="progress-bar progress-bar-aqua" style="width: 20%" role="progressbar"-->
<!--                                                     aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">-->
<!--                                                    <span class="sr-only">20% Complete</span>-->
<!--                                                </div>-->
<!--                                            </div>-->
<!--                                        </a>-->
<!--                                    </li>-->
<!--                                </ul>-->
<!--                            </li>-->
<!--                            <li class="footer">-->
<!--                                <a href="#">View all tasks</a>-->
<!--                            </li>-->
<!--                        </ul>-->
<!--                    </li>-->
                    <!-- User Account Menu -->
                    <li class="dropdown user user-menu">
                        <!-- Menu Toggle Button -->
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                            <!-- The user image in the navbar-->
                            <img src="/adminlte/dist/img/admin.jpg" class="user-image" alt="User Image">
                            <!-- hidden-xs hides the username on small devices so only the image appears. -->
                            <span class="hidden-xs"><?php echo Yii::$app->user->identity['nickname']?></span>
                        </a>
                        <ul class="dropdown-menu">
                            <!-- The user image in the menu -->
                            <li class="user-header">
                                <img src="/adminlte/dist/img/admin.jpg" class="img-circle" alt="User Image">

                                <p>
                                    <?=\Yii::t('app','愿你开心每一天！')?>
                                    <small><?= date('Y-m-d H:i:s');?></small>
                                </p>
                            </li>
                            <!-- Menu Body -->
<!--                            <li class="user-body">-->
<!--                                <div class="row">-->
<!--                                    <div class="col-xs-4 text-center">-->
<!--                                        <a href="#">Followers</a>-->
<!--                                    </div>-->
<!--                                    <div class="col-xs-4 text-center">-->
<!--                                        <a href="#">Sales</a>-->
<!--                                    </div>-->
<!--                                    <div class="col-xs-4 text-center">-->
<!--                                        <a href="#">Friends</a>-->
<!--                                    </div>-->
<!--                                </div>-->
<!--                            </li>-->
                            <!-- Menu Footer-->
                            <li class="user-footer">
<!--                                <div class="pull-left">-->
<!--                                    <a href="#" class="btn btn-default btn-flat">资料</a>-->
<!--                                </div>-->
                                <div class="pull-right">
                                    <a href="/index.php?r=index/logout" class="btn btn-default btn-flat"><?=\Yii::t('app','退出')?></a>
                                </div>
                            </li>
                        </ul>
                    </li>
                    <!-- Control Sidebar Toggle Button -->
                    <li>
<!--                        <a href="#" data-toggle="control-sidebar"><i class="fa fa-gears"></i></a>-->
                    </li>
                </ul>
            </div>
        </nav>
    </header>
    <!-- Left side column. contains the logo and sidebar -->
    <aside class="main-sidebar">

        <!-- sidebar: style can be found in sidebar.less -->
        <section class="sidebar">

            <!-- Sidebar user panel (optional) -->
            <div class="user-panel">
                <div class="pull-left image">
                    <img src="/adminlte/dist/img/admin.jpg" class="img-circle" alt="User Image">
                </div>
                <div class="pull-left info">
                    <p><?php echo Yii::$app->user->identity['nickname']?></p>
                    <!-- Status -->
                    <a href="#"><i class="fa fa-circle text-success"></i> <?=\Yii::t('app','在线')?></a>
                </div>
            </div>

            <!-- /.search form -->

            <?php echo $this->render('sidebarMenu');?>
        </section>
        <!-- /.sidebar -->
    </aside>

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper" id="pjax-container">
        <?php echo $content;?>
    </div>
    <!-- /.content-wrapper -->

    <!-- Main Footer -->
    <footer class="main-footer">
        <!-- To the right -->
        <div class="pull-right hidden-xs">
            <?=date("l Y/m/d")?>
        </div>
        <!-- Default to the left -->
        <strong>Copyright &copy; <?=date("Y")?> <a href="#">Company</a>.</strong> All rights reserved.
    </footer>

    <!-- Control Sidebar -->
    <aside class="control-sidebar control-sidebar-dark">
        <!-- Create the tabs -->
        <ul class="nav nav-tabs nav-justified control-sidebar-tabs">
            <li class="active"><a href="#control-sidebar-home-tab" data-toggle="tab"><i class="fa fa-home"></i></a></li>
            <li><a href="#control-sidebar-settings-tab" data-toggle="tab"><i class="fa fa-gears"></i></a></li>
        </ul>
        <!-- Tab panes -->
        <div class="tab-content">
            <!-- Home tab content -->
            <div class="tab-pane active" id="control-sidebar-home-tab">
                <h3 class="control-sidebar-heading">Recent Activity</h3>
                <ul class="control-sidebar-menu">
                    <li>
                        <a href="javascript:;">
                            <i class="menu-icon fa fa-birthday-cake bg-red"></i>

                            <div class="menu-info">
                                <h4 class="control-sidebar-subheading">Langdon's Birthday</h4>

                                <p>Will be 23 on April 24th</p>
                            </div>
                        </a>
                    </li>
                </ul>
                <!-- /.control-sidebar-menu -->

                <h3 class="control-sidebar-heading">Tasks Progress</h3>
                <ul class="control-sidebar-menu">
                    <li>
                        <a href="javascript:;">
                            <h4 class="control-sidebar-subheading">
                                Custom Template Design
                                <span class="pull-right-container">
                    <span class="label label-danger pull-right">70%</span>
                  </span>
                            </h4>

                            <div class="progress progress-xxs">
                                <div class="progress-bar progress-bar-danger" style="width: 70%"></div>
                            </div>
                        </a>
                    </li>
                </ul>
                <!-- /.control-sidebar-menu -->

            </div>
            <!-- /.tab-pane -->
            <!-- Stats tab content -->
            <div class="tab-pane" id="control-sidebar-stats-tab">Stats Tab Content</div>
            <!-- /.tab-pane -->
            <!-- Settings tab content -->
            <div class="tab-pane" id="control-sidebar-settings-tab">
                <form method="post">
                    <h3 class="control-sidebar-heading">General Settings</h3>

                    <div class="form-group">
                        <label class="control-sidebar-subheading">
                            Report panel usage
                            <input type="checkbox" class="pull-right" checked>
                        </label>

                        <p>
                            Some information about this general settings option
                        </p>
                    </div>
                    <!-- /.form-group -->
                </form>
            </div>
            <!-- /.tab-pane -->
        </div>
    </aside>
    <!-- /.control-sidebar -->
    <!-- Add the sidebar's background. This div must be placed
    immediately after the control sidebar -->
    <div class="control-sidebar-bg"></div>
    <!--    loading层-->
    <div class="posi">
<!--        <img class="posi-img" src="--><?php //echo Utility::userAvatar('/component/loading.gif') ?><!--">-->
    </div>
    <!--错误信息显示层-->
    <div class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" id="ajaxResultModal">
        <div class="modal-dialog modal-sm" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title"></h4>
                </div>
                <div class="modal-body">
                </div>
            </div>
        </div>
    </div>
</div>
<!-- ./wrapper -->

<!-- REQUIRED JS SCRIPTS -->

<!-- Bootstrap 3.3.7 -->
<script src="/adminlte/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<!-- AdminLTE App -->
<script src="/adminlte/dist/js/adminlte.min.js"></script>
<script src="/js/common.js"></script>
<script src="http://cdn.bootcss.com/jquery.form/4.2.2/jquery.form.min.js"></script>
<script src="http://cdn.bootcss.com/jquery.pjax/2.0.1/jquery.pjax.min.js"></script>
<script type="text/javascript" src="/static/plupload/js/plupload.full.min.js"></script>
<script type="text/javascript">
    $(document).pjax('a[data-pjax],#pjax-container a', '#pjax-container', {timeout : 2000});
</script>
<script language="javascript" type="text/javascript"
        src="/97date/WdatePicker.js"></script>
</body>
</html>