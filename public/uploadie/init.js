// onbeforeunload 刷新页面重新加载的确认弹框
// 创建menu
var linkFlashMenu = document.createElement("a");
linkFlashMenu.src = "javascript:void(0);";
linkFlashMenu.id  = "flashMenu";
document.body.appendChild(linkFlashMenu);
Mpupload = {
    currentId: 0,
    length: 0,
    queue: {},
    albumId: albumId || null,
    albumName: albumName || null,
    requestId: requestId || null,
    requestName: requestName || null,
    largeContainer: ".active-photo",
    largeTemplate: "<div class='photo-preview inactive' data-pid='{{id}}'><img src='{{src}}'></div>", // inactive
    thumbContainer: ".photos",
    // thumbTemplate: "<div class='photo-reel-photo' data-pid='{{id}}'><img width='50' height='50' src='{{src}}'></img></div>"
    thumbTemplate: "<div class='photo-reel-photo' data-pid='{{id}}'><span class='img-canvas' style='background-image: url({{src}});'></img></div>"
}
Mpupload.extend = function() {
    var key, object, objects, target, val, _i, _len;
    target = arguments[0], objects = 2 <= arguments.length ? ([].slice).call(arguments, 1) : [];
    for (_i = 0, _len = objects.length; _i < _len; _i++) {
        object = objects[_i];
        for (key in object) {
            val = object[key];
            target[key] = val;
        }
    }
    return target;
};

Mpupload.serviceClientHash = {
    'model'               : 'camera',
    'les'                 : 'les',
    'focal_length'        : 'focal_length',
    'date_time'           : 'taken_at',
    'aperture_value'      : 'aperture',
    'iso_speed_ratings'   : 'iso',
    'shutter_speed_value' : 'shutter_speed'

};

Mpupload.initExif = function(id){
    // if(id){
    //     Mpupload.removeExifDisabled();
    // } else {
    //     Mpupload.resetExifDisabled();
    // }
    var exif = Mpupload.queue[id] || Mpupload.queue[Mpupload.currentId];
    var details = $(Mpupload.photo_details).appendTo(".edit-container").removeClass("disabled").attr("data-pid", id);
    for(var key in Mpupload.serviceClientHash){
        var v = exif[key];
        details.find("#photo-"+Mpupload.serviceClientHash[key]+"").val(v);
    }
    
};
Mpupload.removeExifDisabled = function(){
    $(".edit-container .disabled").removeClass("disabled").addClass("resetDisabled");
    $(".edit-container [disabled=disabled]").removeAttr("disabled").attr("resetDisabled", "resetDisabled");
};

Mpupload.resetExifDisabled = function(){
    $(".edit-container .resetDisabled").removeClass("resetDisabled").addClass("disabled");
    $(".edit-container [resetDisabled=resetDisabled]").removeAttr("resetDisabled").attr("disabled", "disabled");
};


Mpupload.removeFile = function(){
    // 放在最后
    if(Mpupload.length === 0 && Mpupload.currentId === 0){
        Mpupload.resetExifDisabled();
    }
}
Mpupload.jixuButton = function(){
    document.getElementById("flashMenu").style.left = $(this).offset().left + 'px';
    document.getElementById("flashMenu").style.top  = $(this).offset().top + 'px';
}
$(function(){
    // 初始化details
    Mpupload.photo_details = $(".edit-container").html().replace(/(class|disabled)="disabled"/g, "");

    var $field = $("#flashMenu");
    // 判断是否需要初始化upload start
    if($field.length > 0){
        // form_data
        var uploadify_form_data = {}, csrf_token, csrf_param;
        csrf_token = $('meta[name=csrf-token]').attr('content');
        csrf_param = $('meta[name=csrf-param]').attr('content');
        uploadify_form_data[csrf_param] = encodeURI(csrf_token);
        uploadify_form_data['_mp_session'] = cookieSK;
        uploadify_form_data['timestamp'] = Math.random();
        // 配置uploadify
        $field.uploadify({
            'formData'        : uploadify_form_data,
            'buttonText'      : '上传照片',                              //选择按钮显示的字符
            'preventCaching'  : true,
            'height'          : 32,
            'width'           : 105,
            'buttonImage'     : '/images/transparent.gif',
            'swf'             : '/uploadie/uploadify.swf',              //swf文件的位置
            'uploader'        : '/photos/upload',                       //上传的接收者
            // 'cancelImg'       : 'uploadify-cancel.png',
            'folder'          : '/upload',                              //上传图片的存放地址
            'auto'            : true,                                   //选择图片后是否自动上传
            'multi'           : true,                                   //是否允许同时选择多个(false一次只允许选中一张图片)
            'method'          : 'post',
            'queueSizeLimit'  : 20,                                     //最多能选择加入的文件数量
            'fileTypeExts'    : '*.gif; *.jpg; *.png; *.jpeg, *.GIF; *.JPG; *.PNG; *.JPEG',          //允许的后缀
            'fileTypeDesc'    : 'Image Files',                          //允许的格式，详见文档
            'itemTemplate'    : '',
            onDialogClose     : function(queueData){
                var sum = queueData.filesQueued;
                if(sum > 0){
                    // 更新总量 TODO [2014-05-28 00:35:24] ERROR invalid body size.
                    $(".drag-info").hide().parents(".uploader").addClass("loading")
                    $(".wheels-bar .total-wheel").text(sum);
                    $(".wheels-bar .curr-wheel").text(1);
                    document.getElementById("SWFUpload_0").width = 80;
                    document.getElementById("flashMenu").style.width = '80px';
                    document.getElementById("flashMenu").style.left = '0px';
                    document.getElementById("flashMenu").style.top  = '0px';
                    $(".button.submit").on("mouseover", Mpupload.jixuButton); // 或者放在onUploadComplete
                    document.getElementById("flashMenu-button").style.width = '80px';
                }
            },
            onUploadStart     : function(file){
                $(".wheel-bar-filename").text(file.name);
            },
            onUploadComplete  : function(file){
                // 
                $(".loading-progress .area.green").css("width", '0%');
                $(".loading-progress .percentage .value").text(0);
                // 
                $(".wheels-bar .total-wheel").text(this.queueData.filesQueued);
                $(".wheels-bar .curr-wheel").text(this.queueData.filesQueued - this.queueData.queueLength + 1);
                $(".remaining-photos p").text("还可以再上传" + (20 - Mpupload.length) + "张照片");
                Mpupload.initExif(Mpupload.currentId);
                $(".photo-preview[data-pid="+Mpupload.currentId+"] img").Jcrop({aspectRatio: 1, onChange: Mpupload.crop});
                $(".photo-reel-photo[data-pid="+Mpupload.currentId+"]").click();
                if(this.queueData.queueLength === 0){
                    $(".uploader").removeClass("loading").find(".wheels-bar .total-wheel").text(0);
                }
            },
            onUploadSuccess   : function(file, data, response) {        //上传成功后的触发事件
                data = JSON.parse(data);
                Mpupload.length = Mpupload.length + 1;
                Mpupload.currentId = data.id;
                Mpupload.queue[data.id] = data.exif;
                // TODO 获取输入的值 跟exif对比
                // 生成缩略图
                $(Mpupload.largeContainer).append(Mpupload.largeTemplate.replace("{{id}}", data.id).replace("{{src}}", data.large));
                $(Mpupload.thumbContainer).append(Mpupload.thumbTemplate.replace("{{id}}", data.id).replace("{{src}}", data.thumb));
                
            }
        });
    }; // 判断是否需要初始化upload end


    // 
    $(document).on("click", ".photo-reel-photo", function(){
        $(this).addClass("selected").siblings().removeClass("selected");
        var pid = $(this).data('pid');
        $(".photo-preview[data-pid="+pid+"]").removeClass("inactive").siblings().addClass("inactive");
        $(".photo-details[data-pid="+pid+"]").addClass("active").siblings().removeClass("active");
        Mpupload.currentId = pid;
    });
});

Mpupload.crop = function(){
}