$(document).ready(function(){
		$(".sendsms").bind("click", function(){
			var _this = this;
			$.ajax({ url: "cp.php?ac=pm&inajax=1&uid="+_this.name, dataType:"xml", success: function(data){
				s = $(data).find("root").text();
				$("#dialog-form").html(s);
		      }
			});
			
			function updateTips( t ) {
				$(".validateTips")
					.text( t )
					.addClass( "ui-state-highlight" );
				setTimeout(function() {
					$(".validateTips").removeClass( "ui-state-highlight", 1500 );
				}, 500 );
			}

			function checkLength( o, n, min, max ) {
				if ( $.trim(o.val()).length > max || $.trim(o.val()).length < min ) {
					o.addClass( "ui-state-error" );
					updateTips( "您输入的字符必须在" +
						min + " 和 " + max + "之间." );
					return false;
				} else {
					return true;
				}
			}

			function checkRegexp( o, regexp, n ) {
				if ( !( regexp.test( o.val() ) ) ) {
					o.addClass( "ui-state-error" );
					updateTips( n );
					return false;
				} else {
					return true;
				}
			}
			$( "#dialog-form" ).dialog({
				//autoOpen: false,
				height: 300,
				width: 520,
				modal: true,
				buttons: {
					"发送": function() {
						var _th = this;
						var bValid = true;
						$("#message").removeClass( "ui-state-error" );

						bValid = bValid && checkLength( $("#message"), "message", 2, 3000 );
						if ( bValid ) {
							$.post("cp.php?ac=pm&op=send&inajax=1&touid="+ _this.name +"&pmid=0",
								{
								username:$("#username").val(),
							    message: $("#message").val(),
							    formhash : $("#formhash").val(),
							    pmsubmit : 'true',
							    refer : $("#refer").val()
							  	},
							  	function (data){
							  		s = $(data).find("root").text();
							  		if(s.indexOf('ajaxok') > -1){
							  			//updateTips('短信发送成功.');
							  			$( _th ).dialog( "close" )
							  		}else{
								  		updateTips(s);
							  		}
							  	}
							)
						}
					},
					"取消": function() {
						$( this ).dialog( "close" );
					}
				},
				close: function() {
					$("#message").val( "" ).removeClass( "ui-state-error" );
				}
			});
		});	
	})