
$(function(){

    $(".subscribe > input").click(function(){
	  $(".subscribe > input").toggleClass("inpr");
	})

    $(".rechb-li2 > .re-pay").click(function(){
    	$(this).addClass("payactive").parent().siblings().find(".re-pay").removeClass("payactive");
    	
    })


      
});






















