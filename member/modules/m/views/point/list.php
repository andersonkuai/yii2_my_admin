<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <link href="/mobile/20171023/css/mobiscroll.core-2.5.2.css" rel="stylesheet" />
    <link href="/mobile/20171023/css/mobiscroll.android-ics-2.5.2.css" rel="stylesheet" />
    <link rel="stylesheet" href="/mobile/20171023/css/integral.css">
    <script src="https://cdn.bootcss.com/vue/2.2.2/vue.min.js"></script>
    <title>我的积分</title>
</head>

<body>
<?php if(\common\helpers\Func::getPT() == 'web'): ?>
<header class='header'>
    <a href="javascript:history.go(-1)" class='back'></a>
    <span>我的积分</span>
</header>
<?php endif;?>
<div id='app'>
    <ul class="point_title">
        <li class="active" @click="getWhite(whiteRetype,whiteDate,whitePage,true)">
            <span>白积分</span>
        </li>
        <li @click="getRed(redRetype,redDate,redPage,true)">
            <span>红积分</span>
        </li>
        <li @click="getStock(stockRetype,stockDate,stockPage,true)">
            <span>库存积分</span>
        </li>
    </ul>
    <div class='options'>
        <div class="select_group">
            <p>
                <span>全部</span>
                <i class="down_icon"></i>
            </p>
            <ul class='selections' v-if="curTab=='white'">
                <li class="active" @click="getWhite('','',1)">全部</li>
                <li @click="getWhite(1,whiteDate,1)">收入</li>
                <li @click="getWhite('0',whiteDate,1)">支出</li>
            </ul>
            <ul class='selections' v-if="curTab=='red'">
                <li class="active" @click="getRed('','',1)">全部</li>
                <li @click="getRed(1,redDate,1)">收入</li>
                <li @click="getRed('0',redDate,1)">支出</li>
            </ul>
            <ul class='selections' v-if="curTab=='stock'">
                <li class="active" @click="getStock('','',1)">全部</li>
                <li @click="getStock(1,stockDate,1)">收入</li>
                <li @click="getStock('0',stockDate,1)">支出</li>
            </ul>
        </div>
        <div class="trade_date">
            <em class="mid_line"></em>
            <input type="text" readonly placeholder="交易日期" />
            <i class="down_icon"></i>
            <i class="clear_date" v-if="curTab=='white'&&whiteDate!=''" @click="getWhite(whiteRetype,'',1)"></i>
            <i class="clear_date" v-if="curTab=='red'&&redDate!==''" @click="getRed(redRetype,'',1)"></i>
            <i class="clear_date" v-if="curTab=='stock'&&stockDate!=''" @click="getStock(stockRetype,'',1)"></i>
        </div>
    </div>
    <div class="states">
        <span>日期</span>
        <span>状态</span>
        <span>收支</span>
        <span>余额</span>
    </div>
    <div v-show="curTab=='white'">
        <ul class="info_list" v-html='whiteList'>
        </ul>
        <span class="more" @click="getWhite(whiteRetype,whiteDate,whitePage+1)" v-show='whiteMore'>
				更多
			</span>
    </div>
    <div v-show="curTab=='red'">
        <ul class="info_list" v-html='redList'>
        </ul>
        <span class="more" @click="getRed(redRetype,redDate,redPage+1)" v-show='redMore'>
				更多
			</span>
    </div>
    <div v-show="curTab=='stock'">
        <ul class="info_list" v-html='stockList'>
        </ul>
        <span class="more" @click="getStock(stockRetype,stockDate,stockPage+1)" v-show='stockMore'>
				更多
			</span>
    </div>
</div>
<script src="/mobile/20171023/js/jquery.min.js"></script>
<script src="/mobile/20171023/js/mobiscroll.core-2.5.2.js"></script>
<script src="/mobile/20171023/js/mobiscroll.datetime-2.5.1.js"></script>
<script src="/mobile/20171023/js/mobiscroll.core-2.5.2-zh.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $('.point_title>li').click(function () {
            $('.point_title>li').removeClass('active');
            $(this).addClass('active');
        });
        $('.select_group>p').click(function () {
            $('.selections').slideToggle(200);
        })
        $('.selections>li').click(function () {
            var i = $('.selections>li').index(this);
            var tmp = $(this).text();
            $('.select_group>p>span').text(tmp);
            $('.selections').hide();
            $(this).addClass("active").siblings("li").removeClass("active");
        });
    })
    $(function () {
        $(document).bind("click", function (e) {
            var target = $(e.target);
            if (target.closest(".select_group").length == 0) {
                $(".selections").hide();
            }
        });
    })
</script>
<script>
    var vm = new Vue({
        el: '#app',
        data: {
            curTab: 'white',
            whiteList: '', //1
            whiteRetype: 0,
            whiteDate: '',
            whitePage: 1,
            whiteMore: true,
            redList: '', //2
            redRetype: 0,
            redDate: '',
            redPage: 1,
            redMore: true,
            stockList: '', //3
            stockRetype: 0,
            stockDate: '',
            stockPage: 1,
            stockMore: true,
            oldType: ''
        },
        methods: {
            getData: function (type, reType, date, page) {
                var that = this;
                $.ajax({ //type 参数 white red stock；retype 0 支出 1 收入，retype 为空或者不传递参数 表示全部；异步分页 加个参数 ajax=1
                    url: 'http://u.luogow.com/index.php',
                    data: {
                        ajax: 1,
                        r: 'm/point/list',
                        //accesstoken: 'ut59ed53728aec88769',
                        type: type,
                        retype: reType,
                        date: date,
                        page: page
                    },
                    type: 'GET',
                    success: function (data) {
                        var diss = page * 10 - data.totalCount;
                        if (type == 'white') {
                            if (diss < 10) {
                                that.whiteList += data.html;
                                that.whiteMore = !0;
                            } else {
                                that.whiteMore = !1;
                            }
                            $('.red,.stock').hide();
                            $('.white').show();
                        } else if (type == 'red') {
                            if (diss < 10) {
                                that.redList += data.html;
                                that.redMore = !0;
                            } else {
                                that.redMore = !1;
                            }
                            $('.white,.stock').hide();
                            $('.red').show();
                        } else if (type == 'stock') {

                            if (diss < 10) {
                                that.stockList += data.html;
                                that.stockMore = !0;
                            } else {
                                that.stockMore = !1;
                            }
                            $('.red,.white').hide();
                            $('.stock').show();
                        } else {
                            alert('没有更多了')
                        }
                    },
                    error: function (req, textStatus, errorThrown) {
                        console.log(req.status, req.readyState, textStatus)
                    }
                })
            },
            getWhite: function (reType, date, page, tabChange) {
                var that = this,
                    tmpText = $('.selections .active').text();
                that.curTab = 'white';
                $('.trade_date>input').val(date);
                if (that.oldType != 'white') {
                    that.whitePage = 1;
                    that.whiteRetype = '';
                    $('.select_group>p>span').text('全部');
                } else {
                    if (that.whiteRetype != reType) {
                        that.whiteRetype = reType;
                        that.whiteList = '';
                    }
                    if (that.whiteDate != date) {
                        that.whiteDate = date;
                        that.whiteList = '';
                    }
                    if (that.whitePage != page) {
                        that.whitePage = page
                    }
                    if (page == 1) {
                        that.whiteList = '';
                    }
                }
                if (!tabChange) {
                    that.getData('white', that.whiteRetype, that.whiteDate, that.whitePage);
                } else {
                    $('.select_group>p>span').text(tmpText);
                }
                that.oldType = 'white';
            },
            getRed: function (reType, date, page, tabChange) {
                var that = this,
                    tmpText = $('.selections .active').text();
                that.curTab = 'red';
                $('.trade_date>input').val(date);
                if (that.oldType != 'red') {
                    that.redPage = 1;
                    that.redRetype = '';
                    $('.select_group>p>span').text('全部');
                } else {
                    if (that.redRetype != reType) {
                        that.redRetype = reType;
                        that.redList = '';
                    }
                    if (that.redDate != date) {
                        that.redDate = date;
                        that.redList = '';
                    }
                    if (that.redPage != page) {
                        that.redPage = page
                    }
                    if (page == 1) {
                        that.redList = '';
                    }
                }
                if (!tabChange) {
                    that.getData('red', that.redRetype, that.redDate, that.redPage);
                } else {
                    $('.select_group>p>span').text(tmpText);
                }
                that.oldType = 'red';
            },
            getStock: function (reType, date, page, tabChange) {
                var that = this,
                    tmpText = $('.selections .active').text();
                that.curTab = 'stock';
                $('.trade_date>input').val(date);
                if (that.oldType != 'stock') {
                    that.stockPage = 1;
                    that.stockRetype = '';
                    $('.select_group>p>span').text('全部');
                } else {
                    if (that.stockRetype != reType) {
                        that.stockRetype = reType;
                        that.stockList = '';
                    }
                    if (that.stockDate != date) {
                        that.stockDate = date;
                        that.stockList = '';
                    }
                    if (that.stockPage != page) {
                        that.stockPage = page
                    }
                    if (page == 1) {
                        that.stockList = '';
                    }
                }
                if (!tabChange) {
                    that.getData('stock', that.stockRetype, that.stockDate, that.stockPage);
                } else {
                    $('.select_group>p>span').text(tmpText);
                }
                that.oldType = 'stock';
            },
            getInitDate: function () {
                var that = this,
                    date = new Date(),
                    y = date.getFullYear(),
                    m = date.getMonth() + 1,
                    d = date.getDate();
                return y + '-' + m + '-' + d;
            }
        },
        created: function () {
            var that = this;
            that.$nextTick(function () {
                that.getRed();
                that.getStock();
                that.getWhite();
                $(function () {
                    var currYear = (new Date()).getFullYear();
                    var opt = {};
                    opt.date = {
                        preset: 'date'
                    };
                    opt.datetime = {
                        preset: 'datetime'
                    };
                    opt.time = {
                        preset: 'time'
                    };
                    opt.default = {
                        theme: 'android-ics light',
                        display: 'modal',
                        mode: 'scroller',
                        dateFormat: 'yyyy-mm-dd',
                        lang: 'zh',
                        showNow: true,
                        nowText: "今天",
                        startYear: $('.trade_date>input').val() ? $('.trade_date>input').val().substring(0, 4) : (currYear - 10),
                        endYear: currYear,
                        onSelect: function (valueText, inst) {
                            if (that.oldType == 'white') {
                                var reType = that.whiteRetype;
                                that.getWhite(reType, valueText, 1);
                            }
                            if (vm.$data.oldType == 'red') {
                                var reType = that.redRetype;
                                that.getRed(reType, valueText, 1);
                            }
                            if (vm.$data.oldType == 'stock') {
                                var reType = that.stockRetype;
                                that.getStock(reType, valueText, 1);
                            }
                        }
                    };
                    $(".trade_date>input,.trade_date>.down_icon").click(function () {
                        $(".trade_date>input").focus()
                    });
                    $(".trade_date>input").mobiscroll($.extend(opt['date'], opt['default']));
                });

                $('.dwb-n>.dwb').click(function () {
                    alert(3)
                })
            })
        }
    })
</script>
</body>

</html>