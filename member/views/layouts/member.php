<?php
use yii\helpers\Html;
use member\helpers\Utility;

?>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title><?php echo Html::encode($this->title) ?></title>
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
        var CSRF = <?php echo json_encode(['name' => Yii::$app->request->csrfParam, 'value' => Yii::$app->request->getCsrfToken()])?>
    </script>
    <script language="javascript" type="text/javascript"
            src="/97date/WdatePicker.js"></script>
    <style type="text/css">
        /*.nav > li.messages-menu, .nav > li.notifications-menu, .nav > li.tasks-menu, .nav > li:last-child {*/
            /*display: none;*/
        /*}*/

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
    <style type="text/css">
        .skin-blue .main-header .logo {
            background-color: #373d41;
        }

        .skin-blue .main-header .logo:hover {
            background-color: #2a2f36;
        }

        .skin-blue .main-header .navbar {
            background-color: #373d41;
        }

        .skin-blue .main-header .navbar .sidebar-toggle:hover {
            background-color: #2a2f36;
        }

        .skin-blue .sidebar-menu > li.active > a {
            border-left-color: #666666;
        }

        .skin-blue .main-header li.user-header {
            background-color: #00a65a;
        }
    </style>
</head>
<body class="hold-transition skin-blue sidebar-mini" style="width: 100%;height: 100%;">
<div class="wrapper">

    <!-- Main Header -->
    <header class="main-header">

        <!-- Logo -->
        <a href="/" class="logo">
            <!-- mini logo for sidebar mini 50x50 pixels -->
            <span class="logo-mini"><b>代</b></span>
            <!-- logo for regular state and mobile devices -->
            <span class="logo-lg"><b><?= Yii::$app->params['siteName'] ?></b></span>
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
                    <li class="dropdown user user-menu">
                        <!-- Menu Toggle Button -->
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                            <!-- The user image in the navbar-->
                            <img src="<?php echo Utility::userAvatar(Yii::$app->user->identity['avatar']) ?>"
                                 class="user-image" alt="User Image">
                            <!-- hidden-xs hides the username on small devices so only the image appears. -->
                            <span class="hidden-xs"><?php echo Yii::$app->user->identity['username'] ?></span>
                        </a>
                        <ul class="dropdown-menu">
                            <!-- The user image in the menu -->
                            <li class="user-header">
                                <img src="<?php echo Utility::userAvatar(Yii::$app->user->identity['avatar']) ?>"
                                     class="img-circle" alt="User Image">

                                <p>
                                    <?= Yii::$app->user->identity['username'] ?>
                                    - 区域代理
                                </p>
                                <p>
                                    地区：<?= Yii::$app->user->identity['province'] ?><?= Yii::$app->user->identity['city'] ?><?= Yii::$app->user->identity['country'] ?>
                                </p>
                            </li>
                            <!-- Menu Footer-->
                            <li class="user-footer">
                                <div class="pull-left">
                                    <a href="/index.php?r=user/profile" class="btn btn-default btn-flat">资料</a>
                                </div>
                                <div class="pull-right">
                                    <a href="/index.php?r=index/logout" class="btn btn-default btn-flat">退出</a>
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
                    <img src="<?php echo Utility::userAvatar(Yii::$app->user->identity['avatar']) ?>" class="img-circle"
                         alt="User Image">
                </div>
                <div class="pull-left info">
                    <p><?php echo Yii::$app->user->identity['username'] ?></p>
                    <!-- Status -->
                    <a href="#"><i class="fa fa-circle text-success"></i> 在线</a>
                </div>
            </div>

            <?php echo $this->render('sidebarMenu'); ?>
        </section>
        <!-- /.sidebar -->
    </aside>

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper" id="pjax-container">
        <?php echo $content; ?>
    </div>
    <!-- /.content-wrapper -->

    <!-- Main Footer -->
    <footer class="main-footer">
        <!-- To the right -->
        <div class="pull-right hidden-xs">
            <?= date("l Y/m/d") ?>
        </div>
        <!-- Default to the left -->
        <strong>Copyright &copy; <?= date("Y") ?> <a href="#">Company</a>.</strong> All rights reserved.
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
        <img class="posi-img" src="<?php echo Utility::userAvatar('/component/loading.gif') ?>">
    </div>
    <!--    错误信息显示层-->
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
    $(document).pjax('a[data-pjax],#pjax-container a', '#pjax-container', {timeout: 2000});
</script>
</body>
</html>