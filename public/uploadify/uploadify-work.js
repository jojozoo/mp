$(function(){
    var $field = $("#upload-file");
    // 判断是否需要初始化upload start
    if($field.length > 0){
        var workitemTemplate = '<div class="col-sm-6 col-md-3">\
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
                <a href="javascript:void(0);" class="btn btn-primary btn-xs front-cover" id="44-cover" onclick="front_cover(\'44\');return false;">设为封面</a>\
                <a href="javascript:void(0);" class="btn btn-danger btn-xs remove-self" id="44-remove" onclick="remove_self(\'44\');return false;">删除本张</a>\
                <div class="caption caption-border">\
                    <textarea class="once-desc" placeholder="输入图片描述" name="desc[44]"></textarea>\
                    <span>上传时间：${YMDHMS}</span>\
                </div>\
            </div>\
        </div>';
        var avataritemTemplate = false;

        var $tp    = $field.attr('tg'),
            $tg    = {
                'avatar': {
                    'uploader': '/my/set/avatar',
                    'multi': false,
                    'queueSizeLimit' : 1,
                    'itemTemplate' : avataritemTemplate
                },
                'work'  : {
                    'uploader': '/gs',
                    'multi': true,
                    'queueSizeLimit' : 20,
                    'itemTemplate': workitemTemplate
                }
            }[$tp];
        // form_data
        var uploadify_form_data = {};
        var csrf_token = $('meta[name=csrf-token]').attr('content');
        var csrf_param = $('meta[name=csrf-param]').attr('content');
        uploadify_form_data[csrf_param] = encodeURI(csrf_token);
        uploadify_form_data['timestamp'] = Math.random();
        // 配置uploadify
        $field.uploadify({
            'formData'        : uploadify_form_data,
            'buttonText'      : '选择图片',                              //选择按钮显示的字符
            'preventCaching'  : true,
            'swf'             : '/uploadify/uploadify.swf',             //swf文件的位置
            'uploader'        : $tg['uploader'],                        //上传的接收者
            'cancelImg'       : 'uploadify-cancel.png',
            'folder'          : '/upload',                              //上传图片的存放地址
            'auto'            : true,                                   //选择图片后是否自动上传
            'multi'           : $tg['multi'],                           //是否允许同时选择多个(false一次只允许选中一张图片)
            'method'          : 'post',
            'queueSizeLimit'  : $tg['queueSizeLimit'],                  //最多能选择加入的文件数量
            'fileTypeExts'    : '*.gif; *.jpg; *.png; *.jpeg',          //允许的后缀
            'fileTypeDesc'    : 'Image Files',                          //允许的格式，详见文档
            'itemTemplate'    : $tg['itemTemplate'],
            'onUploadSuccess' : function(file, data, response) {        //上传成功后的触发事件
                if($tp == 'avatar'){
                    $("#cutThis").removeClass('disabled');
                    cutAvatar(data);
                } else {
                    insert_page(file, data);
                }
            }
        });
    }; // 判断是否需要初始化upload end
});
// 活动或者相册 插入队列的内容
function insert_page(file, data){
    var data = JSON.parse(data);
    $item = $("#" + file.id).parents(".thumbnail");
    $item.find('.bk-img').html('<img src="' + data.url + '">');
    $item.find('.front-cover').attr({'id':data.id + '-cover', 'onclick':'front_cover(\'' + data.id + '\');return false;'});
    $item.find('.remove-self').attr({'id':data.id + '-remove', 'onclick':'remove_self(\'' + data.id + '\');return false;'});
    $item.find('.once-desc').attr({name: 'desc[' + data.id + ']'});
}
function remove_self(target){
    target = "#" + target + "-remove";
    var url = '/gs/' + parseInt($(target).attr('id'));
    $(target).parents(".col-md-3").fadeOut(function(){
        $(this).remove();
        $.ajax({
          url: url,
          type: 'delete',
          dataType: 'script'
        });
    })
    return false;
};
// 选为封面
function front_cover(target){
    target = "#" + target + "-cover";
    if($(target).hasClass('cover-page')){
        $(target).removeClass('cover-page');
    } else {
        $('.front-cover.cover-page').removeClass('cover-page');
        $(target).addClass('cover-page');
    }
    $('input#p-cover').val(parseInt($(target).attr('id')));
    return false;
};
// 作品/相册上传前检查
function push_work(){
    if ($("#upload-file-queue > .col-md-3").length < 1){
        $("#upload-tip").remove();
        $("#upload-file").css('width', 300);
        $("#upload-file-button").css('float', 'left');
        $("#upload-file").append('<span id="upload-tip" style="margin-left: 20px;line-height: 30px;color: red;">请先上传图片</span>');
        return false;
    }
    // 检查相册是否已选
    if($("input#album").val() == false){
        $('.form-group-album').addClass('has-error').append('<span class="form-error-tip col-sm-4">请选择相册</span>')
        return false;
    }
    // 检查活动是否已选 判断>0去掉了相册上传没有活动的情况
    if($("input#event").length > 0 && $("input#event").val() == false){
        $('.form-group-event').addClass('has-error').append('<span class="form-error-tip col-sm-4">请选择活动</span>')
        return false;
    }
}

// 作品上传时/相册上传时 选择相册
function choose_album(){
    $("#album").val($(this).text());
    $("#p-album").val($(this).attr('href'));
    return false;
}
// 作品上传时 选择活动
function choose_event(){
    $("#event").val($(this).text());
    $("#p-event").val($(this).attr('href'));
    return false;
}


///////////自定义函数star
function cutAvatar(data){
    var data = JSON.parse(data),
        max   = (data.width > data.height) ? data.width : data.height,
        min   = (data.width > data.height) ? data.height : data.width,
        radio = max > 300 ? (300 / max) : 1,
        x2y2  = parseInt(min * radio); // 截图区域x2和y2的值
    var imageArea = $('#cut-area');
    // 显示已上传的图片
    imageArea.attr('src', data.url);
    // 裁剪结果替换
    $(".review img").attr("src", data.url);
    
    var cutJson = {x: 0, y:0, w: x2y2,h: x2y2}; //实际坐标点
    $('input#c_x').val(0);
    $('input#c_y').val(0);
    $('input#c_w').val(parseInt(x2y2 / radio));
    $('input#c_h').val(parseInt(x2y2 / radio));
    //配置imgAreaSelect
    var imgArea = imageArea.imgAreaSelect({
        aspectRatio: '1:1',
        instance: true,  //配置为一个实例，使得绑定的imgAreaSelect对象可通过imgArea来设置
        handles: true,   //选区样式，四边上8个方框,设为corners 4个
        x1: 0,
        y1: 0,
        x2: x2y2,
        y2: x2y2,

        onSelectChange: function(img,selection){
            $.each([200, 100, 50], function(index, item){
               $('.s' + item + ' img').css({
                    width: (data.width * item * radio / selection.width) + 'px',
                    height: (data.height * item * radio / selection.height) + 'px',
                    'margin-left': '-' + (selection.x1 * item / selection.width) + 'px',
                    'margin-top': '-' + (selection.y1 * item / selection.height) + 'px'
                });
            });
        },
        onSelectEnd: function(img,selection){
            // 计算实际对于原图的裁剪坐标
            // 这些值计算的不精确
            // 754x835 => 宽高最大 751
            // 204x244 => 正常
            cutJson.x = parseInt(data.width * selection.x1 / 300);
            cutJson.y = parseInt(data.height * selection.y1 / 300);
            cutJson.w = parseInt(selection.width / radio);
            cutJson.h = parseInt(selection.height / radio);
            $('input#c_x').val(cutJson.x);
            $('input#c_y').val(cutJson.y);
            $('input#c_w').val(cutJson.w);
            $('input#c_h').val(cutJson.h);
        }
    });
};

///////////自定义函数end