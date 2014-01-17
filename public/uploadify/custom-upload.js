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
        'uploader'  : '/images/avatar', //上传的接收者
        'cancelImg' : 'uploadify-cancel.png',
        'folder'    : '/upload',//上传图片的存放地址
        'auto'      : false,    //选择图片后是否自动上传
        'multi'     : false,   //是否允许同时选择多个(false一次只允许选中一张图片)
        'method'    : 'post',
        'debug'     : true,
        'queueSizeLimit' : 1,//最多能选择加入的文件数量
        'fileTypeExts': '*.gif; *.jpg; *.png; *.jpeg', //允许的后缀
        'fileTypeDesc': 'Image Files', //允许的格式，详见文档
     
        'onSelect': function(file) {//选择文件后的触发事件
            $(".gogo").show().click(function(){//自定义的按钮，显示点击执行上传
                $field.uploadify('upload','*');//此处触发上传
                return false;
            });
        },
     
        'onUploadSuccess' : function(file, data, response) {  //上传成功后的触发事件
            $field.uploadify('disable', true);  //(上传成功后)'disable'禁止再选择图片
            var data = JSON.parse(data),
                max   = (data.width > data.height) ? data.width : data.height,
                min   = (data.width > data.height) ? data.height : data.width,
                radio = max > 300 ? (300 / max) : 1,
                x2y2  = parseInt(min * radio); // 截图区域x2和y2的值
            var imageArea = $('#cut-area');
            // 显示已上传的图片
            imageArea.attr('src', data.original);
            // 裁剪结果替换
            $(".review img").attr("src", data.original);
            
            var cutJson = {}; //实际坐标点
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
                    //计算实际对于原图的裁剪坐标
                    // 这些值计算的不精确
                    // 754x835 => 宽高最大 751
                    // 204x244 => 正常
                    cutJson.x = parseInt(data.width * selection.x1 / 300);
                    cutJson.y = parseInt(data.height * selection.y1 / 300);
                    cutJson.width  = parseInt(selection.width / radio);
                    cutJson.height = parseInt(selection.height / radio);
                    console.log(cutJson);
                }
            });
        }
    });
})
