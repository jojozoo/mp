$(function() {
	$('#username').blur(function(){
		var userName=$.trim($(this).val());
		var unLen = userName.replace(/[^\x00-\xff]/g, "**").length;
		if(unLen < 3 || unLen > 15){
			$(this).parent().find('output').remove();
			var msg = unLen < 3 ? '用户名小于3个字符' : '用户名超过 15 个字符'
			$(this).after('<output>&nbsp;<img src="/images/icon_28.jpg">'+ msg +'</output>');
			return false;
		}
		$.get('http://node.manpai.com/check/username',{key:userName},function(e){
			 $("#username").parent().find('output').remove();
			 if (e!='success'){
				 $("#username").after('<output>&nbsp;<img src="/images/icon_28.jpg">'+ e +'</output>');
			 }
		})
	})
	$('#nickname').blur(function(){
		var nickName=$.trim($(this).val());
		var unLen = nickName.replace(/[^\x00-\xff]/g, "**").length;
		if(unLen < 3 || unLen > 15){
			$(this).parent().find('output').remove();
			var msg = unLen < 3 ? '用户名小于3个字符' : '用户名超过 15 个字符'
			$(this).after('<output>&nbsp;<img src="/images/icon_28.jpg">'+ msg +'</output>');
			return false;
		}
		$.get('http://node.manpai.com/check/nickname',{key:nickName},function(e){
			 $("#nickname").parent().find('output').remove();
			 if (e!='success'){
				 $("#nickname").after('<output>&nbsp;<img src="/images/icon_28.jpg">'+ e +'</output>');
			 }
		})
	})
	$('#password').blur(function(){
		$("#password").parent().find('output').remove();
		var password = $.trim($('#password').val());
		if(password.length < 3 || /[\'\"\\]/.test(password)) {
			$("#password").after('<output>&nbsp;<img src="/images/icon_28.jpg">请检查密码是否小于3个字符或包含了非法字符</output>');
		}
	})
	$('#password2').blur(function(){
		$("#password2").parent().find('output').remove();
		var password = $.trim($('#password').val()),
			password2 = $.trim($('#password2').val());
		if(password!=password2) {
			$("#password2").after('<output>&nbsp;<img src="/images/icon_28.jpg">二次输入的密码不一致</output>');
		}
	})
	$('#moblie').blur(function(){
		var value=($.trim($('#moblie').val()));
		var length = value.length;  
	    var moblie =  /(^0{0,1}1[3|4|5|6|7|8|9][0-9]{9}$)/;
	    $("#moblie").parent().find('output').remove();
		if(length == 11 && moblie.test(value)){
			 $.get(url,{phone:value,ajax:true,type:'checkphone'},function(e){
				 if(e>0){
					 $("#moblie").after('<output>&nbsp;<img src="/images/icon_28.jpg">手机已经注册,请换个手机号码再试。</output>');
					 return false;
				 }
			 })
		 }else{
			 $("#moblie").after('<output>&nbsp;<img src="/images/icon_28.jpg">手机格式错误</output>');
		 }
	})
	$('#email').blur(function(){
		var value=($.trim($('#email').val()));
		 $.get('http://node.manpai.com/check/email',{email:value,ajax:true,type:'checkemail'},function(e){
			 $("#email").parent().find('output').remove();
			 if(e==1){
			 }else if (e==-4){
				 $("#email").after('<output>&nbsp;<img src="/images/icon_28.jpg">邮箱格式有误</output>');
				 return false;
			 }else if (e==-5){
				 $("#email").after('<output>&nbsp;<img src="/images/icon_28.jpg">邮箱不允许注册</output>');
				 return false;
			 }else if (e==-6){
				 $("#email").after('<output>&nbsp;<img src="/images/icon_28.jpg">邮箱已经被注册</output>');
				 return false;
			 }else{
				 $("#email").after('<output>&nbsp;<img src="/images/icon_28.jpg">此项为必填</output>');
				
			 }
		 })
	})
	$('#seccode').blur(function(){
		var value=($.trim($('#seccode').val()));
	    $("#seccode").parent().find('output').remove();
	    if(value == '') {
			return;
		} else {
			lastSecCode = value;
		}
		$.get(url,{seccode:value,inajax:1,op:'checkseccode'},function(e){
			s = $(e).find("root").text();
			if(s.indexOf('success') > -1) {
				//
			}else{
				$("#seccode").after('<output>&nbsp;<img src="/images/icon_28.jpg">验证码错误。</output>');
			}
		 })
	})
});
function mailServer(s) {
    var domain = s.split('@')[1]
    switch (domain) {
        case 'xx.com':
            return 'mail.' + domain + ':8111';
            break;
        case 'xx.xx':
            return 'mail.xx' + domain;
            break;
        case 'xx.xx.com':
            return 'xx.mail' + domain;
            break;
        default :
            return 'mail.' + domain;
            break;
    }
}
mailServer('abd@qq.com'); 