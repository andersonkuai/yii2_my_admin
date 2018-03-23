<?php $controllerActionId = Yii::$app->controller->caid;?>
<!-- Sidebar Menu -->
<ul class="sidebar-menu" data-widget="tree">
    <li class="header">HEADER</li>
    <!-- Optionally, you can add icons to the links -->
    <li class="<?php echo $controllerActionId == 'member.index'?'active':''?>"><a data-pjax href="/index.php?r=member/index"><i class="fa fa-dashboard"></i> <span>控制面板</span></a></li>
    <li class="treeview">
        <a href="#"><i class="fa fa-user"></i> <span>个人中心</span>
            <span class="pull-right-container">
                <i class="fa fa-angle-left pull-right"></i>
              </span>
        </a>
        <ul class="treeview-menu">
            <li class="<?php echo $controllerActionId == 'user.profile'?'active':''?>"><a data-pjax href="/index.php?r=user/profile"><i class="fa fa-circle-o"></i>基本资料</a></li>
            <li class="<?php echo $controllerActionId == 'user.password'?'active':''?>"><a data-pjax href="/index.php?r=user/password"><i class="fa fa-circle-o"></i>设置密码</a></li>
        </ul>
    </li>
    <li class="treeview">
        <a href="#"><i class="fa fa-user"></i> <span>下级管理</span>
            <span class="pull-right-container">
                <i class="fa fa-angle-left pull-right"></i>
              </span>
        </a>
        <ul class="treeview-menu">
            <li class="<?php echo $controllerActionId == 'user.index'?'active':''?>"><a data-pjax href="/index.php?r=user/index"><i class="fa fa-circle-o"></i>下级列表</a></li>
        </ul>
    </li>
    <li class="treeview">
        <a href="#"><i class="fa fa-credit-card"></i> <span>订单管理</span>
            <span class="pull-right-container">
                <i class="fa fa-angle-left pull-right"></i>
              </span>
        </a>
        <ul class="treeview-menu">
            <li class="<?php echo $controllerActionId == 'order.index'?'active':''?>"><a data-pjax href="/index.php?r=order/index"><i class="fa fa-circle-o"></i>订单列表</a></li>
        </ul>
    </li>
    <li class="treeview">
        <a href="#"><i class="fa fa-list-alt"></i> <span>数据与统计管理</span>
            <span class="pull-right-container">
                <i class="fa fa-angle-left pull-right"></i>
              </span>
        </a>
        <ul class="treeview-menu">
            <li class="<?php echo $controllerActionId == 'order.test'?'active':''?>"><a data-pjax href="/index.php?r=order/test"><i class="fa fa-circle-o"></i>进账出账统计</a></li>
            <li class="<?php echo $controllerActionId == 'order.test'?'active':''?>"><a data-pjax href="/index.php?r=order/test"><i class="fa fa-circle-o"></i>销量统计</a></li>
            <li class="<?php echo $controllerActionId == 'order.test'?'active':''?>"><a data-pjax href="/index.php?r=order/test"><i class="fa fa-circle-o"></i>退款统计</a></li>
            <li class="<?php echo $controllerActionId == 'order.test'?'active':''?>"><a data-pjax href="/index.php?r=order/test"><i class="fa fa-circle-o"></i>报表查询</a></li>
            <li class="<?php echo $controllerActionId == 'order.test'?'active':''?>"><a data-pjax href="/index.php?r=order/test"><i class="fa fa-circle-o"></i>商品销量排行榜</a></li>
            <li class="<?php echo $controllerActionId == 'order.test'?'active':''?>"><a data-pjax href="/index.php?r=order/test"><i class="fa fa-circle-o"></i>订单详情统计</a></li>
            <li class="<?php echo $controllerActionId == 'order.test'?'active':''?>"><a data-pjax href="/index.php?r=order/test"><i class="fa fa-circle-o"></i>商户销售数据统计</a></li>
            <li class="<?php echo $controllerActionId == 'order.test'?'active':''?>"><a data-pjax href="/index.php?r=order/test"><i class="fa fa-circle-o"></i>交易用户统计</a></li>
        </ul>
    </li>
    <li class="treeview">
        <a href="#"><i class="fa fa-lock"></i> <span>推荐管理</span>
            <span class="pull-right-container">
                <i class="fa fa-angle-left pull-right"></i>
              </span>
        </a>
        <ul class="treeview-menu">
            <li class="<?php echo $controllerActionId == 'order.test'?'active':''?>"><a data-pjax href="/index.php?r=order/test"><i class="fa fa-circle-o"></i>每日新品</a></li>
        </ul>
    </li>
</ul>
<!-- /.sidebar-menu -->
<script type="text/javascript">
    $("li.active").parents('li').addClass('active');
</script>