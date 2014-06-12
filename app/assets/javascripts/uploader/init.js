// onbeforeunload 刷新页面重新加载的确认弹框
// 创建menu
var linkFlashMenu = document.createElement("a");
linkFlashMenu.src = "javascript:void(0);";
linkFlashMenu.id  = "flashMenu";
document.body.appendChild(linkFlashMenu);

Mpupload = {
    totalLength: 0,
    queue: {},
    tipCutInfo: false,
    requestName: null,
    largeContainer: ".active-photo",
    largeTemplate: "<div class='photo-preview inactive' data-pid='{{id}}'><img src='{{src}}'></div>", // inactive
    thumbContainer: ".photos",
    thumbTemplate: "<div class='photo-reel-photo' data-pid='{{id}}'><span class='img-canvas'><img src='{{src}}'></span></div>"
}
// 初始化details
Mpupload.initDetails = function(id){
    var exif = Mpupload.queue[id].exif;
    var details = $(Mpupload.details(id)).appendTo(".edit-container").removeClass("disabled").attr("data-pid", id);
    for(var key in exif){
        var v = exif[key];
        details.find("#photo-exif-" + id + "-" + key).val(v);
    }
    $(".photo-details[data-pid=" + id + "]").find('input, textarea').placeholder();
};
// 初始化地图
Mpupload.initMap = function(id, lat, lon){
    // 应该点击移动到点击位置
    var mapObj,
        param = {level: 12};
    if(!lat || !lon){
        param = $.extend(param,{center: AMap.LngLat(lon, lat), level: 10});
    }
    mapObj = new AMap.Map("GDMAP-" + id, param);
    var marker = new AMap.Marker({  
        position: mapObj.getCenter(),
        draggable:true, //点标记可拖拽
        cursor:'move',  //鼠标悬停点标记时的鼠标样式
        raiseOnDrag:true, //鼠标拖拽点标记时开启点标记离开地图的效果
        title: '坐标不正确?可自行拖拽到正确的拍摄地点.'
    });
    // 移动光标获取坐标事件
    var moveIconListener = AMap.event.addListener(marker, 'dragend', function(e){
        Mpupload.queue[id].exif.lat = e.lnglat.lat;
        Mpupload.queue[id].exif.lon = e.lnglat.lng;
    });
    // 点击地图某一点,icon移动并获取坐标事件
    var clickIconListener = AMap.event.addListener(mapObj,'click',function(e){
        var newPo = {j: e.lnglat.getLat(), l: e.lnglat.getLng()};
        marker.setPosition(newPo);
        Mpupload.queue[id].exif.lat = newPo.j;
        Mpupload.queue[id].exif.lon = newPo.l;
    });

    marker.setMap(mapObj);
    // Mpupload.queue[id].gdMap   = mapObj;
    // Mpupload.queue[id].gdMark  = marker;
};

Mpupload.initQueue = function(data){
    var exif = {}, 
        exifHash = {
            'model'               : 'camera',
            'les'                 : 'les',
            'focal_length'        : 'focal_length',
            'date_time'           : 'taken_at',
            'aperture_value'      : 'aperture',
            'iso_speed_ratings'   : 'iso',
            'shutter_speed_value' : 'shutter_speed',
            'gps_latitude'        : 'lat',
            'gps_longitude'       : 'lon'
        };
    for(var key in exifHash){
        var nk = exifHash[key];
        exif[nk] = data.exif[key];
    }

    var ow = parseFloat(data.exif.original_width),
        lw = parseFloat(data.exif.large_width),
        rw = lw,
        rh = parseFloat(data.exif.large_height);
    if(lw > 1070){
        rw = 1070;
        rh = 700 * (1070 / lw);
    }
    Mpupload.queue[data.id] = {
        title: null,
        desc: null,
        request_id: null,
        request_name: null,
        album_id: null,
        album_name: null,
        warrant: '5',
        tags: [],
        exif: exif,
        gdMap: null,
        gdMark: null,
        jcrop: null,
        cropAttr: {
            oscale: ow / (lw > 1070 ? 1070 : lw),
            oh: parseFloat(data.exif.original_height),
            rw: rw,
            rh: rh
        },
        crop: {
            w: 0,
            h: 0,
            x: 0,
            y: 0
        }
    };
}

// 
Mpupload.initCrop = function(id){
    // TODO Bug 要等图片加载完了
    var attr = Mpupload.queue[id].cropAttr;
    $(".photo-preview[data-pid=" + id + "] img").Jcrop({
        aspectRatio: 1, 
        onChange: cutPhoto, 
        onSelect: cutPhoto
    });

    function cutPhoto(cood){
        var w = cood.w * attr.oscale,
            h = cood.h * attr.oscale,
            x = cood.x * attr.oscale,
            y = cood.y * attr.oscale;
        Mpupload.queue[id].crop.w = h > attr.oh ? attr.oh : w;
        Mpupload.queue[id].crop.h = h > attr.oh ? attr.oh : h;
        Mpupload.queue[id].crop.x = x; // xy坐标暂时没测出什么问题
        Mpupload.queue[id].crop.y = y;
        
        var rx = 50 / cood.w,
            ry = 50 / cood.h;

        $(".photo-reel-photo[data-pid="+id+"] img").css({
            width: Math.round(rx * attr.rw) + 'px',
            height: Math.round(ry * attr.rh) + 'px',
            marginLeft: '-' + Math.round(rx * cood.x) + 'px',
            marginTop: '-' + Math.round(ry * cood.y) + 'px'
        });
    }
    // console.log($(".photo-preview[data-pid=" + id + "] img"));
    // Mpupload.queue[id].jcrop = $.Jcrop(".photo-preview[data-pid=" + id + "] img", {
    //     aspectRatio: 1, 
    //     onChange: Mpupload.cutPhoto, 
    //     onSelect: Mpupload.cutPhoto
    // });
}

Mpupload.details = function(id){
    return Mpupload.photo_details.replace(/\{\{id\}\}/ig, function(word){
        return id;
    });
}

Mpupload.getValues = function(){
    
}

// flash移动按钮
Mpupload.flashMoveButton = function(){
    var width = $(this).hasClass("submit") ? 80 : 105;
    document.getElementById("flashMenu").style.left = $(this).offset().left + 'px';
    document.getElementById("flashMenu").style.top  = $(this).offset().top + 'px';
    document.getElementById("SWFUpload_0").width = width;
    document.getElementById("flashMenu").style.width = width + 'px';
    document.getElementById("flashMenu-button").style.width = width + 'px';
}



$(function(){
    $('input, textarea').placeholder();
    var clone = $(".edit-container").clone();
    Mpupload.photo_details = clone.find("[disabled]").removeAttr("disabled").end().find("input, textarea").val("").end().find(".disabled").removeClass("disabled").end().html();
    // 配置uploadify
    $('#flashMenu').uploadify();


    // 选择小组图时
    $(document).on("click", ".photo-reel-photo", function(){
        if(Mpupload.totalLength > 12){
            var current = $(this).index();
            if(current < 5){
                current = 5;
            }
            if(current > (Mpupload.totalLength - 7)){
                current = Mpupload.totalLength - 7;
            }
            $(".photos").css("left", -(current - 5) * 55);
        }

        $(this).addClass("selected").siblings().removeClass("selected");
        var pid = $(this).data('pid');
        $(".photo-preview[data-pid="+pid+"]").removeClass("inactive").siblings().addClass("inactive");
        $(".photo-details[data-pid="+pid+"]").addClass("active").siblings().removeClass("active");
    });

    // 创建相册
    $(document).on("click", ".create-new-set", function(){
        if($(this).hasClass("disabled")){
            return false;
        };
        $(this).parents(".place-photo").find(".place_selection_wrap").hide().end().find(".confirm_new_set_wrap, .set_name_field_wrap").show();
    });
    // 取消创建相册
    $(document).on("click", ".cancel-new-set", function(){
        $(this).parents(".place-photo").find(".place_selection_wrap").show().end().find(".confirm_new_set_wrap, .set_name_field_wrap").hide();
    });
    // 常用标签添加
    $(document).on("click", ".tag-changyong a", function(){
        if($(this).hasClass("disabled")){
            return false;
        };
        var val = $(this).text(); 
        $(this).parents('.tag-textfield').find('input').val(val + ",").keydown();
        return false;
    });
    // 删除本张
    $(document).on("click", "input.button.remove", function(){
        var _this = $(".photo-reel-photo.selected");
        if(_this.length > 0){
            var pid = _this.data("pid");
            if(confirm("确定删除本张?")){
                $("div[data-pid="+pid+"]").remove();
                Mpupload.totalLength -= 1;
                $(".remaining-photos p").text("还可以再上传" + (20 - Mpupload.totalLength) + "张照片");
                delete Mpupload.queue[pid];
                if(_this.next() > 0){
                    _this.next().click();
                } else if(_this.prev() > 0){
                    _this.prev().click();
                } else if($(".photo-reel-photo").length > 0){
                    $(".photo-reel-photo:last").click();   
                } else {
                    // 移除继续上传的mouse事件
                    $(".button.browse_files.action").on("mouseover", Mpupload.flashMoveButton);
                    $(".button.submit").off("mouseover", Mpupload.flashMoveButton);
                    // end
                    $(".drag-info").show();
                    $(".photo-details.disabled").addClass("active");
                }
            }
            return;
        }

    });

    // 完成上传
    $(document).on("click", ".button.action.finish", function(){
        if($(".photo-reel .photos").length < 1 || Mpupload.totalLength < 1 || $.isEmptyObject(Mpupload.queue)){
            return false;
        }
        // 有数据实现上传
        // 获取数据
        // 上传数据
    });
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
            if(val.length > 5){
                alert("最长5个字符");
                event.returnValue = false;
                event.cancel = true;
                return;
            }
            var str = '<div class="tag"><div class="name">'+ val +'</div><div class="remove">×</div></div>';
            var _width = $(this).width(),
                _jk    = $(this).parent().before(str).prev().width(),
                _rw    = (_width - _jk) < 170 ? 170 : (_width - _jk);
            $(this).val('').css({width: _rw});
            event.returnValue = false;
            event.cancel = true;
        }
    });

    $(document).on("click", ".map .remove", function(){
        $(this).parents(".tag").remove();
    });

});

