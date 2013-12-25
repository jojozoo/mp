$(document).ready(function(){
		$(".more").bind("click", function(){
			var _this = this;
			_eq = $(_this).parents("dl").siblings(".fans_bg").index($(_this).parents("dl").next());
			if( ! $(_this).hasClass("on")){
				$(_this).html('');
				$(_this).addClass('on');
				$.get("space.php?do=friend&view=getmore&uid="+this.name+"&hash="+hash('fr'), function(data,status){
				if(status == 'success' && data.indexOf('fans_bg')>0){
					//data = data.indexOf('fans_bg')>0 ? data : 'you_do_not_have_permission_to_visit';
					$(_this).parents("dl").after(data);//fans_bg
					$(_this).html('收起 <img src="images/icon_24.jpg">');
				}
			});
			}else{
				$(".fans_bg:eq("+_eq+")").remove();
				$(_this).html('更多 <img src="images/icon_24.jpg">');
				$(_this).removeClass('on');
			}
		});
		$("body").on("click",".removefollow", function(){
			var _this = this;
			$( "#friend_dialog-confirm" ).dialog({
				resizable: false,
				width: 460,
				height:200,
				modal: true,
				buttons: {
					"确认": function() {
						var _th = this;
						$.get("cp.php?ac=friend&op=removefollow&inajax=1&uid="+_this.name+"&hash="+hash('fr'), function(data,status){
							if(status == 'success'){
								$( _th ).dialog( "close" );
								$(_this).removeClass('removefollow').addClass('addfollow').text("+关注");
							}
						})
					},
					"取消": function() {
						$( this ).dialog( "close" );
					}
				}
			})
		});
		$("body").on("click",".addfollow",function(){
			var _this = this;
			console.log(this.name);
			$.get("cp.php?ac=friend&op=addfollow&inajax=1&uid="+_this.name, function(data,status){
				if(status == 'success'){
					$(_this).removeClass('addfollow').addClass('removefollow').text("取消关注");
				}
			})
		});
		$(".removefan").bind("click", function(){
			var _this = this;
			$( "#friend_dialog-confirm" ).dialog({
				resizable: false,
				width: 460,
				height:200,
				modal: true,
				buttons: {
					"确认": function() {
						var _th = this;
						$.get("cp.php?ac=friend&op=removefans&inajax=1&uid="+_this.name, function(data,status){
							if(status == 'success'){
								$( _th ).dialog( "close" );
								window.location.reload();
							}
						})
					},
					"取消": function() {
						$( this ).dialog( "close" );
					}
				}
			})
		});
		
		$(".send_poke").bind("click", function(){
			var _this = this;
			$( "#dialog-poke" ).html('<span style="position:absolute;left:45%;top:45%"><img src=images/loading.gif></span>');
			$.get('space.php?do=poke&op=reply&inajax=1&uid='+_this.name,function(data,status){
				if(status=="success"){
					html=$(data).find('root').text();
					$("#dialog-poke").html(html);
				}
				
			});
			$( "#dialog-poke" ).dialog({
				resizable: false,
				width: 710,
				height:440,
				modal: true
			})
		});
	})