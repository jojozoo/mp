$(function(){
	$("#sign-in #submit-push").click(function(){
		$("#sign-in #login").blur();
		$("#sign-in #pwd").blur();
		if($("#sign-in .has-error").length > 0){
			return false;
		}
		$(this).submit();
	});
	$("#sign-in #login").blur(usernameBlur);
	$("#sign-in #pwd").blur(passwordBlur);
	// username blur
	function usernameBlur(){
		var value = $(this).val();
		var reg = /[\w\.\@\u4e00-\u9fa5]{2,}/;
		if(!(reg.test(value))){
			$(this).next().text("请输入正确的帐号/邮箱/手机").parent().addClass('has-error');
			return false
		}
		$(this).next().text('').parent().removeClass('has-error');
	}
	// password blur
	function passwordBlur(){
		var value = $(this).val();
		if(value.length < 5 || value.lenght > 32){
			$(this).next().text("密码长度5..32位").parent().addClass('has-error');
			return false;
		}
		$(this).next().text('').parent().removeClass('has-error');
	};

	//登陆，注册效果
	$(document).on('click', 'a.sign-in', function(){
		$("#sign-up").stop().animate({"opacity":0,"right":-500}, 300,function(){
			$(this).css("display","none");
			$("#sign-in").css("display","block").stop().animate({"opacity":1,"right":"35px"}, 300);
		});
	});

	$(document).on('click', 'a.sign-up', function(){
		$("#sign-in").stop().animate({"opacity":0,"right":-500}, 300,function(){
			$(this).css("display","none");
			$("#sign-up").css("display","block").stop().animate({"opacity":1,"right":"35px"}, 300);
		});
	});

	$(".background").css({width: window.screen.width, height: window.outerHeight});
	// window.screen.width
	// window.outerHeight
	// window.screenTop
	// window.screen.height
	$(".background img").css({width: window.screen.width, height: window.outerHeight, opacity: 1});
	if(From == 'sign_in'){
		$("a.sign-in:first").click();
	}
	if(From == 'sign_up'){
		$("a.sign-up:first").click();
	}
	$(window).resize(function(){
		var _b = $(".beian").width();
		var _l = window.screen.width / 2 - _b / 2 - 40;
		$(".beian").css({left: _l});
		var _h = $(window).height();
		$(".background").css({width: window.screen.width, height: _h});
		var _t = _h - window.screen.height;
		$(".background img").css({top: _t, opacity: 1});
	});
})