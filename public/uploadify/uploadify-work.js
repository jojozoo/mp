$(function(){
    $field = $("#upload-file");
    var uploadify_form_data = {};
    var csrf_token = $('meta[name=csrf-token]').attr('content');
    var csrf_param = $('meta[name=csrf-param]').attr('content');
    uploadify_form_data[csrf_param] = encodeURI(csrf_token);
    uploadify_form_data['timestamp'] = Math.random();
    $field.uploadify({//配置uploadify
        'formData'  : uploadify_form_data,
        'scriptData' : uploadify_form_data,
        'buttonText': '选择图片',  //选择按钮显示的字符
        'preventCaching' : true,
        'swf'       : '/uploadify/uploadify.swf', //swf文件的位置
        'uploader'  : '/gs', //上传的接收者
        'cancelImg' : 'uploadify-cancel.png',
        'folder'    : '/upload',//上传图片的存放地址
        'auto'      : true,    //选择图片后是否自动上传
        'multi'     : true,   //是否允许同时选择多个(false一次只允许选中一张图片)
        'method'    : 'post',
        // 'debug'     : true,
        'queueSizeLimit' : 30,//最多能选择加入的文件数量
        'fileTypeExts': '*.gif; *.jpg; *.png; *.jpeg', //允许的后缀
        'fileTypeDesc': 'Image Files', //允许的格式，详见文档
        'onUploadSuccess' : function(file, data, response) {  //上传成功后的触发事件
            // $field.uploadify('disable', true);  //(上传成功后)'disable'禁止再选择图片
            var data = JSON.parse(data);
            var str  = '<div class="col-sm-6 col-md-3">'
                str +=     '<div class="thumbnail">'
                str +=         '<img alt="P9" src="' + data.url + '">'
                str +=         '<div class="caption caption-border">'
                str +=             '<a href="' + data.id + '" class="btn btn-default btn-xs front-cover">设为封面</a>'
                str +=             '<a href="/gs/' + data.id + '" class="btn btn-default btn-xs remove-self">删除本张</a>'
                // str +=             '<div class="pull-right">'
                // str +=                 '<a href="javascript:void(0);" class="btn btn-default btn-xs">'
                // str +=                     '<i class="icon-arrow-left"></i>'
                // str +=                      '左移'
                // str +=                 '</a>'
                // str +=                 '<a href="javascript:void(0);" class="btn btn-default btn-xs">'
                // str +=                     '右移'
                // str +=                     '<i class="icon-arrow-right"></i>'
                // str +=                 '</a>'
                // str +=             '</div>'
                str +=             '<textarea class="once-desc form-control" placeholder="输入图片描述" name="desc[' + data.id + ']"></textarea>'
                str +=             '<span>上传时间：' + data.time + '</span>'
                str +=         '</div>'
                str +=     '</div>'
                str += '</div>'
            $(str).appendTo(".uploads").find('.remove-self').click(remove_self).end().find('.front-cover').click(front_cover);
        }
    });
    
    $(".choose-album").on('click', choose_album);
    $(".choose-event").on('click', choose_event);
    $(".remove-self").on('click', remove_self);
    $(".front-cover").on('click', front_cover);
    function remove_self(){
        var url = $(this).attr('href');
        $(this).parents(".col-md-3").fadeOut(function(){
            $(this).remove();
            $.ajax({
              url: url,
              type: 'delete',
              dataType: 'script'
            });
        })
        return false;
    };
    function front_cover(){
        $('.front-cover').removeAttr('style');
        $(this).css({background: 'orange', color: '#fff'});
        $('input#p-cover').val($(this).attr('href'));
        return false;
    };

    // 提交
    $("#push-work").click(function(){
        // 检查图片是否上传
        if ($(".uploads > .col-md-3").length < 1){
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
        // 检查活动是否已选
        if($("input#event").val() == false){
            $('.form-group-event').addClass('has-error').append('<span class="form-error-tip col-sm-4">请选择活动</span>')
            return false;
        }
        // 检查其他
    });
});

function choose_album(){
    $("#album").val($(this).text());
    $("#p-album").val($(this).attr('href'));
    return false;
}
function choose_event(){
    $("#event").val($(this).text());
    $("#p-event").val($(this).attr('href'));
    return false;
}


