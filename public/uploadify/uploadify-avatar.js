$(function(){
    $field = $("#upload-file");
    var uploadify_form_data = {};
    var csrf_token = $('meta[name=csrf-token]').attr('content');
    var csrf_param = $('meta[name=csrf-param]').attr('content');
    uploadify_form_data[csrf_param] = encodeURI(csrf_token);
    uploadify_form_data['timestamp'] = Math.random();
    $field.uploadify({//配置uploadify
        'formData'  : uploadify_form_data,
        'buttonText': '上传头像',  //选择按钮显示的字符
        'preventCaching' : true,
        'swf'       : '/uploadify/uploadify.swf', //swf文件的位置
        'uploader'  : '/my/set/avatar', //上传的接收者
        'cancelImg' : 'uploadify-cancel.png',
        'folder'    : '/upload',//上传图片的存放地址
        'auto'      : true,    //选择图片后是否自动上传
        'multi'     : false,   //是否允许同时选择多个(false一次只允许选中一张图片)
        'method'    : 'post',
        // 'debug'     : true,
        'queueSizeLimit' : 1,//最多能选择加入的文件数量
        'fileTypeExts': '*.gif; *.jpg; *.png; *.jpeg', //允许的后缀
        'fileTypeDesc': 'Image Files', //允许的格式，详见文档
        'onUploadSuccess' : function(file, data, response) {
            //上传成功后的触发事件
            // $field.uploadify('disable', true);  //(上传成功后)'disable'禁止再选择图片
            $("#cutThis").removeClass('disabled');
            cutAvatar(data);
        }
    });
    
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
});
















