$(function(){
	CITY = {"\u5317\u4eac":null,"\u4e0a\u6d77":null,"\u5929\u6d25":null,"\u91cd\u5e86":null,"\u9999\u6e2f":null,"\u6fb3\u95e8":null,"\u53f0\u6e7e":["\u53f0\u5317","\u9ad8\u96c4","\u57fa\u9686","\u53f0\u4e2d","\u53f0\u5357","\u65b0\u7af9","\u5609\u4e49"],"\u6cb3\u5317":["\u90af\u90f8","\u77f3\u5bb6\u5e84","\u4fdd\u5b9a","\u5f20\u5bb6\u53e3","\u627f\u5fb7","\u5510\u5c71","\u5eca\u574a","\u6ca7\u5dde","\u8861\u6c34","\u90a2\u53f0","\u79e6\u7687\u5c9b"],"\u5c71\u897f":["\u6714\u5dde","\u5ffb\u5dde","\u592a\u539f","\u5927\u540c","\u9633\u6cc9","\u664b\u4e2d","\u957f\u6cbb","\u664b\u57ce","\u4e34\u6c7e","\u5415\u6881","\u8fd0\u57ce"],"\u5185\u8499":["\u547c\u4f26\u8d1d\u5c14","\u547c\u548c\u6d69\u7279","\u5305\u5934","\u4e4c\u6d77","\u4e4c\u5170\u5bdf\u5e03","\u901a\u8fbd","\u8d64\u5cf0","\u9102\u5c14\u591a\u65af","\u5df4\u5f66\u6dd6\u5c14","\u9521\u6797\u90ed\u52d2","\u5174\u5b89\u76df","\u963f\u62c9\u5584\u76df"],"\u8fbd\u5b81":["\u6c88\u9633","\u94c1\u5cad","\u5927\u8fde","\u978d\u5c71","\u629a\u987a","\u672c\u6eaa","\u4e39\u4e1c","\u9526\u5dde","\u8425\u53e3","\u961c\u65b0","\u8fbd\u9633","\u671d\u9633","\u76d8\u9526","\u846b\u82a6\u5c9b"],"\u5409\u6797":["\u957f\u6625","\u5409\u6797","\u5ef6\u8fb9","\u56db\u5e73","\u901a\u5316","\u767d\u57ce","\u8fbd\u6e90","\u677e\u539f","\u767d\u5c71"],"\u9ed1\u9f99\u6c5f":["\u54c8\u5c14\u6ee8","\u9f50\u9f50\u54c8\u5c14","\u9e21\u897f","\u7261\u4e39\u6c5f","\u4e03\u53f0\u6cb3","\u4f73\u6728\u65af","\u9e64\u5c97","\u53cc\u9e2d\u5c71","\u7ee5\u5316","\u9ed1\u6cb3","\u5927\u5174\u5b89\u5cad","\u4f0a\u6625","\u5927\u5e86"],"\u6c5f\u82cf":["\u5357\u4eac","\u65e0\u9521","\u9547\u6c5f","\u82cf\u5dde","\u5357\u901a","\u626c\u5dde","\u76d0\u57ce","\u5f90\u5dde","\u6dee\u5b89","\u8fde\u4e91\u6e2f","\u5e38\u5dde","\u6cf0\u5dde","\u5bbf\u8fc1"],"\u6d59\u6c5f":["\u821f\u5c71","\u8862\u5dde","\u676d\u5dde","\u6e56\u5dde","\u5609\u5174","\u5b81\u6ce2","\u7ecd\u5174","\u6e29\u5dde","\u4e3d\u6c34","\u91d1\u534e","\u53f0\u5dde"],"\u5b89\u5fbd":["\u5408\u80a5","\u829c\u6e56","\u868c\u57e0","\u6dee\u5357","\u9a6c\u978d\u5c71","\u6dee\u5317","\u94dc\u9675","\u5b89\u5e86","\u9ec4\u5c71","\u6ec1\u5dde","\u961c\u9633","\u5bbf\u5dde","\u5de2\u6e56","\u516d\u5b89","\u4eb3\u5dde","\u6c60\u5dde","\u5ba3\u57ce"],"\u798f\u5efa":["\u798f\u5dde","\u53a6\u95e8","\u5b81\u5fb7","\u8386\u7530","\u6cc9\u5dde","\u6f33\u5dde","\u9f99\u5ca9","\u4e09\u660e","\u5357\u5e73"],"\u6c5f\u897f":["\u9e70\u6f6d","\u65b0\u4f59","\u5357\u660c","\u4e5d\u6c5f","\u4e0a\u9976","\u629a\u5dde","\u5b9c\u6625","\u5409\u5b89","\u8d63\u5dde","\u666f\u5fb7\u9547","\u840d\u4e61"],"\u5c71\u4e1c":["\u83cf\u6cfd","\u6d4e\u5357","\u9752\u5c9b","\u6dc4\u535a","\u5fb7\u5dde","\u70df\u53f0","\u6f4d\u574a","\u6d4e\u5b81","\u6cf0\u5b89","\u4e34\u6c82","\u6ee8\u5dde","\u4e1c\u8425","\u5a01\u6d77","\u67a3\u5e84","\u65e5\u7167","\u83b1\u829c","\u804a\u57ce"],"\u6cb3\u5357":["\u5546\u4e18","\u90d1\u5dde","\u5b89\u9633","\u65b0\u4e61","\u8bb8\u660c","\u5e73\u9876\u5c71","\u4fe1\u9633","\u5357\u9633","\u5f00\u5c01","\u6d1b\u9633","\u6d4e\u6e90","\u7126\u4f5c","\u9e64\u58c1","\u6fee\u9633","\u5468\u53e3","\u6f2f\u6cb3","\u9a7b\u9a6c\u5e97","\u4e09\u95e8\u5ce1"],"\u6e56\u5317":["\u6b66\u6c49","\u8944\u6a0a","\u9102\u5dde","\u5b5d\u611f","\u9ec4\u5188","\u9ec4\u77f3","\u54b8\u5b81","\u8346\u5dde","\u5b9c\u660c","\u6069\u65bd","\u795e\u519c\u67b6\u6797\u533a","\u5341\u5830","\u968f\u5dde","\u8346\u95e8","\u4ed9\u6843","\u5929\u95e8","\u6f5c\u6c5f"],"\u6e56\u5357":["\u5cb3\u9633","\u957f\u6c99","\u6e58\u6f6d","\u682a\u6d32","\u8861\u9633","\u90f4\u5dde","\u5e38\u5fb7","\u76ca\u9633","\u5a04\u5e95","\u90b5\u9633","\u6e58\u897f","\u5f20\u5bb6\u754c","\u6000\u5316","\u6c38\u5dde"],"\u5e7f\u4e1c":["\u5e7f\u5dde","\u6c55\u5c3e","\u9633\u6c5f","\u63ed\u9633","\u8302\u540d","\u60e0\u5dde","\u6c5f\u95e8","\u97f6\u5173","\u6885\u5dde","\u6c55\u5934","\u6df1\u5733","\u73e0\u6d77","\u4f5b\u5c71","\u8087\u5e86","\u6e5b\u6c5f","\u4e2d\u5c71","\u6cb3\u6e90","\u6e05\u8fdc","\u4e91\u6d6e","\u6f6e\u5dde","\u4e1c\u839e"],"\u6d77\u5357":["\u6d77\u53e3","\u4e09\u4e9a","\u4e94\u6307\u5c71","\u743c\u6d77","\u510b\u5dde","\u6587\u660c","\u4e07\u5b81","\u4e1c\u65b9","\u6f84\u8fc8\u53bf","\u5b9a\u5b89\u53bf","\u5c6f\u660c\u53bf","\u4e34\u9ad8\u53bf","\u767d\u6c99","\u660c\u6c5f","\u4e50\u4e1c","\u9675\u6c34","\u4fdd\u4ead","\u743c\u4e2d"],"\u5e7f\u897f":["\u9632\u57ce\u6e2f","\u5357\u5b81","\u5d07\u5de6","\u6765\u5bbe","\u67f3\u5dde","\u6842\u6797","\u68a7\u5dde","\u8d3a\u5dde","\u8d35\u6e2f","\u7389\u6797","\u767e\u8272","\u94a6\u5dde","\u6cb3\u6c60","\u5317\u6d77"],"\u7518\u8083":["\u5170\u5dde","\u91d1\u660c","\u767d\u94f6","\u5929\u6c34","\u5609\u5cea\u5173","\u6b66\u5a01","\u5f20\u6396","\u5e73\u51c9","\u9152\u6cc9","\u5e86\u9633","\u5b9a\u897f","\u9647\u5357","\u4e34\u590f","\u7518\u5357"],"\u9655\u897f":["\u897f\u5b89","\u54b8\u9633","\u5ef6\u5b89","\u6986\u6797","\u6e2d\u5357","\u5546\u6d1b","\u5b89\u5eb7","\u6c49\u4e2d","\u5b9d\u9e21","\u94dc\u5ddd"],"\u65b0\u7586":["\u5854\u57ce","\u54c8\u5bc6","\u548c\u7530","\u963f\u52d2\u6cf0","\u514b\u5b5c\u52d2\u82cf","\u535a\u5c14\u5854\u62c9","\u514b\u62c9\u739b\u4f9d","\u4e4c\u9c81\u6728\u9f50","\u77f3\u6cb3\u5b50","\u660c\u5409","\u4e94\u5bb6\u6e20","\u5410\u9c81\u756a","\u5df4\u97f3\u90ed\u695e","\u963f\u514b\u82cf","\u963f\u62c9\u5c14","\u5580\u4ec0","\u56fe\u6728\u8212\u514b","\u4f0a\u7281"],"\u9752\u6d77":["\u897f\u5b81","\u7389\u6811","\u6d77\u4e1c","\u6d77\u5357","\u6d77\u897f","\u6d77\u5317","\u9ec4\u5357","\u679c\u6d1b"],"\u5b81\u590f":["\u94f6\u5ddd","\u77f3\u5634\u5c71","\u5434\u5fe0","\u56fa\u539f","\u4e2d\u536b"],"\u56db\u5ddd":["\u6210\u90fd","\u6500\u679d\u82b1","\u81ea\u8d21","\u7ef5\u9633","\u5357\u5145","\u8fbe\u5dde","\u9042\u5b81","\u5e7f\u5b89","\u5df4\u4e2d","\u6cf8\u5dde","\u5b9c\u5bbe","\u8d44\u9633","\u5185\u6c5f","\u4e50\u5c71","\u7709\u5c71","\u51c9\u5c71","\u96c5\u5b89","\u7518\u5b5c","\u963f\u575d","\u5fb7\u9633","\u5e7f\u5143"],"\u8d35\u5dde":["\u8d35\u9633","\u9075\u4e49","\u5b89\u987a","\u9ed4\u5357","\u9ed4\u4e1c\u5357","\u9ed4\u897f\u5357","\u94dc\u4ec1","\u6bd5\u8282","\u516d\u76d8\u6c34"],"\u4e91\u5357":["\u897f\u53cc\u7248\u7eb3","\u5fb7\u5b8f","\u662d\u901a","\u6606\u660e","\u5927\u7406","\u7ea2\u6cb3","\u66f2\u9756","\u4fdd\u5c71","\u6587\u5c71","\u7389\u6eaa","\u695a\u96c4","\u666e\u6d31","\u4e34\u6ca7","\u6012\u6c5f","\u8fea\u5e86","\u4e3d\u6c5f"],"\u897f\u85cf":["\u62c9\u8428","\u65e5\u5580\u5219","\u5c71\u5357","\u6797\u829d","\u660c\u90fd","\u90a3\u66f2","\u963f\u91cc"]}
	// 插入所有省份
	for(var p in CITY){
		$(".psal").append("<a href='javascript:void(0);' class='cityitem pr'>"+p+"</a>");
	}
	function cityitem(){
		var name = $(this).text(),
			item = CITY[name];
		// 如果选择了省
		if(item && $.isArray(item)){
			$(".csal").html('');
			$("#photo_location").attr('pr', $(this).text());
			for(var i=0; i < item.length; i++){
				$("<a href='javascript:void(0);' class='cityitem cr' p='"+name+"'>"+item[i]+"</a>").appendTo(".csal").click(cityitem);
			}
		} else {
			if($(this).parent().hasClass('psal')){
				$("#photo_location").val($(this).text());
				$(".locationval").html('<b>['+$(this).text()+'<a href="javascript:void(0);" tar="photo_location" class="oterdel">x</a>]</b>');
			// 选择了地级市
			} else {
				var _val = $("#photo_location").attr('pr') + " " + $(this).text();
				$(".locationval").html('<b>['+_val+'<a href="javascript:void(0);" tar="photo_location" class="oterdel">x</a>]</b>');
				$("#photo_location").val(_val);
			}
			$(this).parents(".fm-item-s-div").hide();
		}
		return false;
	}
	// 
	$(document).on('click', '.cityitem', cityitem);
	if($('#clickupload').length > 0){
		$('#clickupload').uploadify();
	}

	// 单击上传
	$(document).on("click", "a.submit", function(){
		var _queue = $(".uploadcom .col-md-12[data-tpid]"),
			_event = $("#event_div input").val(),
			_title = $("#title_div input").val(),
			_desc = $("#desc_div textarea").val();


		if(_queue.length < 1){
			MPMSG("error", "还没有上传作品");
			return false;
		}
		if(_event == ""){
			MPMSG("error", "活动必选");
			return false;
		}
		if(_title == ""){
			MPMSG("error", "标题不能为空");
			return false;
		}
		if(_desc == ""){
			MPMSG("error", "内容不能为空");
			return false;
		}
		$("input.finish").click();
	});

	// 向上移动
	$(document).on("click", ".gototop", function(){
		var _this = $(this).parents(".col-md-12"),
			_col12 = _this.prev();
		if(_col12){
			_col12.before(_this);
		}
	});
	// 向下移动
	$(document).on("click", ".gotobottom", function(){
		var _this = $(this).parents(".col-md-12"),
			_col12 = _this.next();
		if(_col12 && !_col12.hasClass("upcm2")){
			_col12.after(_this);
		}
	});
	// 封面
	$(document).on("click", ".gotocover", function(){
		$(".setcover").hide();
		$(this).parents(".col-md-12").find(".setcover").show();
		var gl = $(this).parents(".col-md-12").data("tpid");
		$("#photo_gl_id").val(gl);
	});
	// 删除
	$(document).on("click", ".gotodel", function(){
		var _glid = $(this).parents(".col-md-12").data("tpid");
		$(this).parents(".col-md-12").fadeOut(300, function(){
			$(this).remove();
			if($("#photo_gl_id").val()  == _glid){
				$(".uploadcom .gotocover:last").click();
			}
			
		});
	});
	// 显示某一个标签的fm-item-s-div
	$(document).on("click", ".gotoshow", function(){
		$(this).parents(".fm-item").siblings().find(".fm-item-s-div").hide();
		var _fm = $(this).parents(".fm-item").find(".fm-item-s-div");
		if(_fm.is(":hidden")){
			_fm.show();
		} else {
			_fm.hide();
		}
		
	});
	// 选择warrant
	$(document).on("click", ".warrant-row input", function(){
		var _val = $(this).val();
		$(".warrantval").html('<b>[<i class="ils_'+_val+'"></i><a class="oterdel" tar="photo_warrant" href="javascript:void(0);">x</a>]</b>')
		$("#photo_warrant").val(_val);
		$(this).parents(".fm-item-s-div").hide();
	})
	// 选择标签
	$(document).on("keydown", ".tag_field input", function(e){
		var val = $.trim($(this).val());
		if(val == ""){
			return;
		}
		e = e || window.event;
		var lastChar = val.slice(-1);
		if(lastChar == ','){
			val = val.replace(",", "");
			e.keyCode = 9;
		}
		if(e.keyCode == 9 || e.keyCode == 13){
			if(val.length > 10){
				alert("最长10个字符");
				e.returnValue = false;
				e.cancel = true;
				return false;
			}
			var str = '<div class="tag"  v="'+val+'"><div class="name">'+ val +'</div><div class="remove">×</div></div>';
			var str1 = '<b class="tag" v="'+val+'">['+ val +'<a href="javascript:void(0);" class="remove">x</a>]</b>';
			$(".tagsval").append(str1);
			$(this).parent().before(str);
			$(this).val("");
			$("#photo_tags").val($("b.tag").map(function(){return $(this).attr("v")}).get().join(","))
			e.returnValue = false;
			e.cancel = true;
			return false;
		}
	});
	 // 常用标签添加
	$(document).on("click", ".tag-cy a", function(){
		var val = $(this).text(); 
		$(this).parents('.fm-item-s-div').find('input').val(val + ",").keydown();
		return false;
	});
	// 删除标签
	$(document).on("click", ".remove", function(){
		var _val = $(this).parents('.tag').attr('v');
		$(".tag[v="+_val+"]").remove();
		$("#photo_tags").val($("b.tag").map(function(){return $(this).attr("v")}).get().join(","))
	});
	$(document).on("click", ".dsortspan input", function(){
		var _val = $(this).val(),
			_text = $(this).next().text();
		$(".dsortval").html('<b>['+_text+']</b>');
		$(this).parents(".fm-item-s-div").hide();
	});
	// 默认删除
	$(document).on("click", ".oterdel", function(){
		var _tar = $(this).attr("tar");
		$(this).parents("b").remove();
		$('#' + _tar).removeAttr('value');
	});
	// 选择活动
	$(document).on("click", ".chooseevent", function(){
		var _val = $(this).text(),
			_eid = $(this).attr("eid");
		$("#photo_event_id").val(_eid).next().text(_val);
		$('#custom-modal').modal('hide');
	});
});