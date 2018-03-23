/**
 * Created by Lup on 2017/9/4.
 */
$(function () {
   $("#recharge_btn").on("click", function () {
       recharge_money = $(this).parents(".form-inline").find("input[name='recharge_money']").first().val();
       recharge_money = parseFloat(recharge_money);

       var recharge_unit = $("input[name='recharge_unit']:checked").val();
       if(isNaN(recharge_unit)){
           alert("请选择单位!");
           return false;
       }

       if(isNaN(recharge_money)){
           alert("请输入正确的充值金额!");
       }else{

           var postData = [{name:'recharge_money',value: recharge_money}, {name:'recharge_unit',value: recharge_unit}];
           if(typeof CSRF != "undefined"){
               postData.push(CSRF);
           }
           $.post(
               "?r=recharge/create",
               postData,
               function (data) {
                    if(data.code === 1){
                        $("#rechargeDialog").modal("toggle");
                        window.location.href="?r=recharge/pay&recharge_sn="+data.data.recharge_sn;
                    }else{
                        alert(data.msg);
                    }
               },'json'
           );
       }
   });

   $("#rechargeDialog").on("hidden.bs.modal", function (e) {
       $(this).find("input[name='recharge_money']").first().val("");
   })
});