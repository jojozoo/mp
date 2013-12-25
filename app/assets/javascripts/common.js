/**
 *快拍快拍网 公共 JS
 *
**/

//验证码
function seccode() {
	var img = 'do.php?ac=seccode&rand='+Math.random();
	document.writeln('<img id="img_seccode" src="'+img+'" align="absmiddle">');
}
function updateseccode() {
	var img = 'do.php?ac=seccode&rand='+Math.random();
	if($('#img_seccode')) {
		$('#img_seccode').attr('src',img);
	}
}
//头部导航下拉js
function dropMenu(obj){
	$(obj).each(function(){
		var theSpan = $(this);
		var theMenu = theSpan.find(".submenu");
		//var tarHeight = theMenu.height();
		theMenu.css({opacity:0});
			theSpan.hover(
				function(){
					$(this).addClass("selected");
					//theSpan.css("z-index","99").css("position","relative").css("display","block");
					theSpan.css({"z-index":"99","position":"relative","display":"inline-block"});
					theMenu.stop().show().animate({opacity:1},400);
				},
				function(){
					$(this).removeClass("selected");
					theMenu.stop().animate({opacity:0},400,
						function(){
							$(this).css({display:"none"});
						}
					);
				}
			);
		}
	);
}

//首页图片显示
function dropPhoto(obj){
	$(obj).each(function(){
		var theSpan = $(this);
		var thePhoto = theSpan.find(".Up_photo");
		thePhoto.hide();
			theSpan.hover(
				function(){
					thePhoto.stop().slideToggle(200);
				}
			);
		}
	);
}

//个人四角
function dropSingle(obj){
	$(obj).each(function(){
	var theSpan = $(this);
	var theSingle= theSpan.find(obj+"on")
	var thePhoto = theSpan.find(obj+"Text");
		theSingle.fadeTo(0,0);
		thePhoto.hide();
			theSpan.hover(
				function(){
					theSingle.stop().fadeTo(0,0,
						function(){
							thePhoto.stop(true,true).slideDown(400);		
						}
					);
				},
				function(){
					thePhoto.stop(true,true).slideUp(400);
				}
			);
		}
	);
}

//加载
$(document).ready(function(){
	
	//头部下拉
	dropMenu(".drop-menu-effect");
	
	//关闭窗口
	$(".close").click(
		function () {
			$(this).parent().parent().fadeTo(400, 0, function () {
				$(this).stop().slideUp(400);
				}
			);
			return false;
		}
	);
		
	//头部搜素	
	/*
	$("#search").focus(
		function(){
			var value=$(".input01");
			var keywords=this.defaultValue;
				if(value.val()==keywords){
					value.val('');
				}
			}
		);
		
	$("#search").blur(
		function(){
			var value=$(".input01");
			var keywords=this.defaultValue;
				if(value.val()==""){
					value.val(keywords);
				}
			}
		);	*/
var exif={};	
var status=0;
	$(".Single_03").mouseover(function(){
		var _this=this;
		var id=_this.id;
		var value;
		var url='space.php?do=activity&type=exif&inajax=1&picid=';
		if(!exif[id]&&status==0){
			status=1;
		$.getJSON(url+id).done(function(e){
			exif[id]=e;
			status=0;
			html='';
				if(e[id].制造商)html+="品牌："+e[id].制造商+"<br/>";
				if(e[id].型号)html+="型号："+e[id].型号+"<br/>";
				if(e[id].焦距)html+="焦距："+e[id].焦距+"<br/>";
				if(e[id].光圈)html+="光圈："+e[id].光圈+"<br/>";
				if(e[id].快门速度)html+="快门速度："+e[id].快门速度+"<br/>";
				if(e[id].ISO感光度)html+="ISO："+e[id].ISO感光度+"<br/>";
				if(e[id].曝光补偿)html+="曝光补偿："+e[id].曝光补偿+"<br/>";
				if(e[id].拍摄时间)html+="拍摄时间："+e[id].拍摄时间+"<br/>";
				if(html){
			$(_this).find(".Single_03Text").html(html);
				}else{
				$(_this).hide();	
				}
		})
		}
	})
});

function checkAll(form, name) {
	for(var i = 0; i < form.elements.length; i++) {
		var e = form.elements[i];
		if(e.name.match(name)) {
			e.checked = form.elements['chkall'].checked;
		}
	}
}
/*判断为空*/
function isEmpty(o){
	return o==""?true:false;
}
/*判断是否为合适长度 6-32 位*/
function isProperLen(o){
	var len=o.replace(/[^\x00-\xff]/g,"11").length;
	if(len>32||len<6){
		return false;
	}else{
		return true;
	}
}
/*判断是否为Email*/
function isEmail(o){
	var reg=/^\w+\@[a-zA-Z0-9]+\.[a-zA-Z]{2,4}$/i;
	return reg.test(o);
}
/*判断url是否正确*/
function isUrl(o){
	var reg=/^(http\:\/\/)?(\w+\.)+\w{2,3}((\/\w+)+(\w+\.\w+)?)?$/;
	return reg.test(o);
}
/*判断是否为电话号码 可以是手机或 固定电话*/
function isPhone(v){
	var reg=/^1[3|4|5|8][0-9]\d{4,8}$/;
	if(reg.test(v)){
		return true;
	}else{
		return false;
	}
}
function isNum(o){
	var reg=/[^\d]+/;
	return reg.test(o)?false:true;
}
function isChinese(o){
	var reg=/^[\u4E00-\u9FA5]+$/;
	return reg.test(o);
}


function FormCheck(id,check){

	var om=check;
	if(!id){
		return false;
	}
		for(var o in check){
			$("#"+check[o]).blur(
				function(){
					
				
					var Xvalue=$.trim($(this).val());
					eSrc=$(this);
					if(isEmpty(Xvalue)){
						ShowMes(eSrc,"此项不能为空","span02");
					}else{
						switch(check[o]){
						case om.mail:
							if(!isEmail(Xvalue)){
								ShowMes(eSrc,"邮箱地址不正确","span02");
							}else{
								ShowMes(eSrc,"","span01");
							}
						break;
				
						case om.phone:
							if(!isPhone(Xvalue)){
								ShowMes(eSrc,"电话号码格式不正确","span02");
							}else{
								ShowMes(eSrc,"","span01");
							}
						break;
				
						case om.num :
							if(!isNum(Xvalue)){
								ShowMes(eSrc,"只能是数字","span02");
							}else{
								ShowMes(eSrc,"","span01");
							}
						break;
				
						case om.chinese :
							if(!isChinese(Xvalue)){
								ShowMes(eSrc,"必须为汉字","span02");
							}else{
								ShowMes(eSrc,"","span01")
							}
						break;
	
						case om.url :
							if(!isUrl(Xvalue)){
								ShowMes(eSrc,"url地址不正确","span02");
							}else{
								ShowMes(eSrc,"","span01");
							}
						break;
				
						case om.length :
							if(!isProperLen(Xvalue)){
								ShowMes(eSrc,"长度不正确不正确","span02");
							}else{
								ShowMes(eSrc,"","span01");
							}
						break;
	
						default :
							ShowMes(eSrc,"1234","span01")
					}
				}
			}
		)
	}
}

function gopage(realpage, url)
{
	var page = $('#pagenum').val();
	var repstr = 'pagenum';
	if(isNaN(page)){
		page = $('#pagesnum').val();
		repstr = 'pagesnum';
	}
	if(isNaN(page) || page > realpage || page < 1) {
		alert('请输入1~'+realpage+'之间的整数');
		$('pagenum').focus();
		return false;
	}
	url = url.replace(repstr,parseInt(page))
	location.href = url;
}
function gopages(realpage, url)
{
	var page = $('#pagesnum').val();
	if(isNaN(page) || page > realpage || page < 1) {
		alert('请输入1~'+realpage+'之间的整数');
		$('pagenum').focus();
		return false;
	}
	url = url.replace("pagesnum",parseInt(page))
	location.href = url;
}

function activekeyenter(input, realpage, url)
{
	document.onkeydown = pagenumkeyenter;
	function pagenumkeyenter(e){
		var event = e ? e : (window.event ? window.event : null);
		if (event.keyCode == 13)
		{
			gopage(realpage, url);
			return false;
		}
	};
	input.onblur = function(){
		document.onkeydown = null;
	};
}
function ShowMes(obj,message,type){
obj.parent().find("span").attr("class",type).html(type);
}
function isUndefined(variable) {
	return typeof variable == 'undefined' ? true : false;
}
//得到一个定长的hash值,依赖于 stringxor()
function hash(string, length) {
	var length = length ? length : 32;
	var start = 0;
	var i = 0;
	var result = '';
	filllen = length - string.length % length;
	for(i = 0; i < filllen; i++){
		string += "0";
	}
	while(start < string.length) {
		result = stringxor(result, string.substr(start, length));
		start += length;
	}
	return result;
}

function stringxor(s1, s2) {
	var s = '';
	var hash = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
	var max = Math.max(s1.length, s2.length);
	for(var i=0; i<max; i++) {
		var k = s1.charCodeAt(i) ^ s2.charCodeAt(i);
		s += hash.charAt(k % 52);
	}
	return s;
}
/*依赖于jquery*/
function ajaxget(url, showid, waitid, postion){
	$.get(url,function(data,status){
		if(postion == 'prepend'){
			$(showid).prepend(data);
		}else{
			$(showid).append(data);
		}
	  });
}
/**jquery类判断字符串长度
	方法:
		id:输入框ID
		num:检测数量
		output:显示数量
**/	
(function ($) {
    $.checklength = function (id,num,output) {
        var text=$("#"+id).val();
			text=curLength(text,num);
			$("#"+id).val(text);
		var counter=GetLength(text);
    $("#"+output).text(parseInt(num-counter));
		$("#"+id).keyup(function() {
			var text=$(this).val();
				text=curLength(text,num);
				$("#"+id).val(text);
			var counter=GetLength(text);
			
			if(counter>=num)$("#"+id).attr("maxlength",counter);
			$("#"+output).html(parseInt(num-counter));
		});	
    };
	GetLength = function(str) {
		var realLength = 0, len = str.length, charCode = -1;
		for (var i = 0; i < len; i++) {
			charCode = str.charCodeAt(i);
			if (charCode >= 0 && charCode <= 128) realLength += 1;
			else realLength += 2;
		}
		return realLength;
	};
	curLength=function(val,max){
		var returnValue = ''; 
		var byteValLen = 0; 
		for (var i = 0; i < val.length; i++) { 
			charCode = val.charCodeAt(i);
			if (charCode >= 0 && charCode <= 128) 
				byteValLen += 1; 
			else 
				byteValLen += 2; 

			if (byteValLen > max) 

			break; 
		returnValue += val[i]; 
		} 
	return returnValue; 
	} 
})(jQuery);

//JS按钮active
(function($){
	$.active=function(value,active){
		if($(value).is("."+active)){
			$(value).removeClass(active);
		}else{
			$(value).addClass(active);
		}
	}
})(jQuery)