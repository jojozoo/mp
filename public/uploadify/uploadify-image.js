$(function(){
    var $field = $("#upload-file");
    // 判断是否需要初始化upload start
    if($field.length > 0){
        var imageitemTemplate = '<div class="col-sm-6 col-md-3">\
            <div class="thumbnail">\
                <a href="javascript:void(0);" class="bk-img">\
                </a>\
                <div id="${fileID}" class="uploadify-queue-item">\
                    <div class="cancel">\
                        <a href="javascript:$(\'#${instanceID}\').uploadify(\'cancel\', \'${fileID}\')">X</a>\
                    </div>\
                    <div class="fileName">${fileName} (${fileSize})</div>\
                    <div class="data"></div>\
                    <div class="uploadify-progress">\
                        <div class="uploadify-progress-bar"><!--Progress Bar--></div>\
                    </div>\
                </div>\
                <a href="javascript:void(0);" class="btn btn-primary btn-xs js-image-cover">设为封面</a>\
                <a href="javascript:void(0);" class="btn btn-danger btn-xs js-image-remove">删除本张</a>\
                <div class="caption caption-border">\
                    <textarea class="once-desc" placeholder="输入图片描述"></textarea>\
                    <span>上传时间：${YMDHMS}</span>\
                </div>\
            </div>\
        </div>';
        // form_data
        var uploadify_form_data = {};
        var csrf_token = $('meta[name=csrf-token]').attr('content');
        var csrf_param = $('meta[name=csrf-param]').attr('content');
        uploadify_form_data[csrf_param] = encodeURI(csrf_token);
        uploadify_form_data['timestamp'] = Math.random();
        // 配置uploadify
        $field.uploadify({
            'formData'        : uploadify_form_data,
            'buttonText'      : '上传图片',                              //选择按钮显示的字符
            'preventCaching'  : true,
            'height'          : 35,
            'swf'             : '/uploadify/uploadify.swf',             //swf文件的位置
            'uploader'        : '/gs/upload',                           //上传的接收者
            'cancelImg'       : 'uploadify-cancel.png',
            'folder'          : '/upload',                              //上传图片的存放地址
            'auto'            : true,                                   //选择图片后是否自动上传
            'multi'           : true,                                   //是否允许同时选择多个(false一次只允许选中一张图片)
            'method'          : 'post',
            'queueSizeLimit'  : 20,                                     //最多能选择加入的文件数量
            'fileTypeExts'    : '*.gif; *.jpg; *.png; *.jpeg',          //允许的后缀
            'fileTypeDesc'    : 'Image Files',                          //允许的格式，详见文档
            'itemTemplate'    : imageitemTemplate,
            'onUploadSuccess' : function(file, data, response) {        //上传成功后的触发事件
                insert_page(file, data);
            }
        });
        $("#push-image").on('click', push_image);
    }; // 判断是否需要初始化upload end
});
// 活动或者相册 插入队列的内容
function insert_page(file, data){
    var data = JSON.parse(data);
    $item = $("#" + file.id).parents(".thumbnail");
    $item.find('.bk-img').html('<img src="' + data.url + '">');
    $item.find('.js-image-cover, .js-image-remove').attr({'tid':data.id});
    $item.find('.once-desc').attr({name: 'desc[' + data.id + ']'});
}
// 作品/相册上传前检查
function push_image(){
    if ($("#upload-file-queue > .col-md-3").length < 1){
        $("#upload-tip").remove();
        $("#upload-file").css('width', 300);
        $("#upload-file-button").css('float', 'left');
        $("#upload-file").append('<span id="upload-tip" style="margin-left: 20px;line-height: 30px;color: red;">请先上传图片</span>');
        return false;
    }
    
    if ($("#imageeventid").val() == ""){
        $("#imageeventid").parents('.form-group').removeClass('has-error');
        $("#imageeventid").parents('.form-group').find(".form-error-tip").remove();
        $("#imageeventid").parents('.form-group').addClass('has-error');
        $("#imageeventid").parents('.form-group').append('<span class="form-error-tip col-sm-4">不能为空</span>');
        return false;
    }
}

// 作品上传时 选择活动
function choose_event(eventid, eventname){
    $("#imageeventid").val(eventid);
    $("#image_event_id").val(eventname);
    $("#imageeventid").parents('.form-group').removeClass('has-error');
    $("#imageeventid").parents('.form-group').find(".form-error-tip").remove();
    $('#custom-modal').modal('hide');
    return false;
}
