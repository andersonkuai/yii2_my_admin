var UTILITY = {};
UTILITY.CHECK = {
    selector : "input[name='checkids[]']",
    init:function(selector){
        this.selector = selector;
        return this;
    },
    all:function(elm){
        $(this.selector).prop('checked', $(elm).is(':checked'));
    },
    post:function(url, tips){
        tips = typeof tips != "undefined" ? tips : '确定要进行此操作？';
        if(!confirm(tips)) return false;
        if($(this.selector).serializeArray().length == 0){
            alert('请先选择一条记录！');
            return false;
        }
        var postData = $(this.selector).serializeArray();
        if(typeof CSRF != "undefined"){
            postData.push(CSRF);
        }
        $.post( url, postData, function(data){
            if( data.code == 1 ){
                window.location.href = window.location.href;
            }else{
                alert(data.msg);
            }
        }, 'json');
    }
};
UTILITY.OPERATE = {
    get : function(url, tips){
        tips = typeof tips != "undefined" ? tips : '确定要进行此操作？';
        if(!confirm(tips)) return false;
        $.getJSON(url, function(data){
            if( data.code == 1 ){
                window.location.href = window.location.href;
            }else{
                alert(data.msg);
            }
        });
    }
};
UTILITY.UPLOAD = {
    bind : function( selector ){
        var that = this;
        $(selector).each(function(){
            var browseid = $(this).attr('id');
            if( !browseid ){
                browseid = "u-" + Math.random().toString(16).substr(2);
                $(this).attr( 'id', browseid);
            }
            that.init(browseid);
        });
    },
    init : function(browseid){
        //实例化一个plupload上传对象
        var uploader = new plupload.Uploader({
            browse_button : browseid, //触发文件选择对话框的按钮，为那个元素id
            url : '/index.php?r=member/plupload' , //服务器端的上传页面地址
            flash_swf_url : '/static/plupload/js/Moxie.swf', //swf文件，当需要使用swf方式进行上传时需要配置该参数
            max_file_size: '2mb',//限制为2MB
            filters: [{title: "Image files",extensions: "jpg,gif,png"}],//图片限制
        });
        if( CSRF ){
            var obj = {};
            var key = CSRF.name;
            obj[key] = CSRF.value;
            uploader.setOption('multipart_params', obj);
        }
        //在实例对象上调用init()方法进行初始化
        uploader.init();
        uploader.bind('FileUploaded',function(uploader,files,data){
            data = JSON.parse(data.response);
            if(data.code == 1){
                $( "#" + browseid ).parent('span').prev('input').val(data.data);
            }else{
                alert(data.msg);
            }
        });
        uploader.bind('Error' , function(uploader, args) {
            // Called when error occurs
            alert(args.message);
        });
        uploader.bind('FilesAdded',function(uploader,files){
            //console.log(files[0].size);
            uploader.start();
        });
    }
};
UTILITY.VERIFYCODE = {
    //todo
    get:function(){
        alert('已发送到手机！8888');
    }
};
UTILITY.PJAX = {
    load: function(url){
        $.pjax({
            url: url,
            container: '#pjax-container'
        });
    }
};
UTILITY.TOOL = {
    uniqid: function(prefix){
        if(!prefix) prefix = '';
        return prefix + (parseInt((new Date()).getTime()/1000)).toString(16) + (Math.floor(Math.random()*1000000)).toString(16) + Math.floor(Math.random()*10000);
    },
    open_load: function () {        //打开loading动态图片及遮罩层
      $(".posi").show();
    },
    close_load: function () {       //关闭loading动态图片及遮罩层
        $(".posi").hide();
    },
    ajax_result_modal: function (type, error_msg) {     //显示ajax请求后的结果(如成功或失败)
        if(type == 1){
            $("#ajaxResultModal").find(".modal-title").text("成功!");
        }else{
            $("#ajaxResultModal").find(".modal-title").text("出错了!");
        }
        $("#ajaxResultModal").find(".modal-body").text(error_msg);
        $("#ajaxResultModal").modal("show");
    }
};
