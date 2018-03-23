var PT = {
    successEvents:{},
    errorEvents:{},
    isApp:function(){
        return typeof(androidJsObject) != "undefined" || typeof(iosJsObject) != "undefined";
    },
    click:function( type, json, success, error ){

        if( typeof success == 'function') this.successEvents[type] = success;
        if( typeof error == 'function') this.errorEvents[type] = error;

        if( typeof(androidJsObject) != "undefined" ){

            var jsonStr = typeof(json) == "undefined" ? "{}" : JSON.stringify(json);
            androidJsObject.JumpPageTypeJumpData( type, jsonStr );
            return false;
        }else if( typeof(iosJsObject) != "undefined" ){

            var jsonStr = typeof(json) == "undefined" ? "{}" : JSON.stringify(json);
            iosJsObject.JumpPageTypeJumpData( type, jsonStr );
            return false;
        }else{

            return true;
        }
    },
    success:function(type, jsonStr){
        if( typeof this.successEvents[type] == 'function'){
            var data = typeof(jsonStr) == "string" ? JSON.parse(jsonStr) : {};
            this.successEvents[type](data);
        }
    },
    error:function(type, jsonStr){
        if( typeof this.errorEvents[type] == 'function'){
            var data = typeof(jsonStr) == "string" ? JSON.parse(jsonStr) : {};
            this.errorEvents[type](data);
        }
    },
    open:function(url, title){
        return PT.click("url", {jumpData:url, title:title});
    }
};
