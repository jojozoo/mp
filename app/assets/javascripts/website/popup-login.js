

$(function() {

    // href data-url 登录后的跳转地址 data-init
    var POPBox = {
        isIE6: false,
        hostname: window.location.host,
        isInitSignIn: true,
        isChecked: true,
        emailRegexp: /^(?:\w+\.?)*\w+@(?:\w+\.)+\w+$/,
        phonePhoneRegexp: /^(([0\+]\d{2,3}-)?(0\d{2,3})-)?(\d{7,8})(-(\d{3,}))?$/,
        usernameRegexp: /[\w\u4e00-\u9fa5]{2,10}/,
        passwordRegexp: /^\s*[\@A-Za-z0-9\!\#\$\%\^\&\*\.\~]{5,16}\s*$/,
        redirectUrl: window.location.href
    };
    //创建登录框
    POPBox.mppopupBox = function(settings) {
        var box;
        //已经存在
        if ($('.mppopup-box').length != 0) {
            POPBox.mppopupBoxShow();
        } else {
            box = '<div class="mppopup-box" id="mppopup-box">' +
                        '<div class="mppopup-box-left mppopup-box-item pop-left">' +
                            '<div class="mppopup-box-sign mppopup-box-sign_in pop-login" style="display: '+ (POPBox.isInitSignIn ? 'block' : 'none') +'">' +
                                '<h3>立即登录</h3>' +
                                '<form method="post" action="/sign_in" id="mppopup-box-sing_in-form">' +
                                    '<ul>' +
                                        '<li>' +
                                            '<span class="inputTip">输入帐号/邮箱/手机</span>' +
                                            '<input type="text" place-holder="正确帐号邮箱或手机" name="user[username]" class="txt" tabindex="100" />' +
                                        '</li>' +
                                        '<li>' +
                                            '<span class="inputTip">输入登录密码</span>' +
                                            '<input type="password" place-holder="密码" name="user[password]" class="txt" maxlength="16" tabindex="101" />' +
                                        '</li>' +
                                        '<li>' +
                                            '<input type="hidden" name="remember" value="on" />' +
                                            '<input type="hidden" name="return_to" value="' + POPBox.redirectUrl + '" />' +
                                            '<label class="pboxtb checked">保持登录状态</label>' +
                                            '<a href="/forgot" class="get-back-password" target="_blank" title="找回密码">找回密码</a>' +
                                        '</li>' +
                                        '<li>' +
                                            '<input type="button" id="mppopup-box-btn" class="pboxtb mppopup-submit-btn" value="" tabindex="102" />' +
                                            '<a href="javascript:void(0);" class="left40_blue fblue sign-up_now" target="_blank">没有帐号，立即注册</a>' +
                                        '</li>' +
                                    '</ul>' +
                                '</form>' +
                            '</div>' +
                            '<div class="mppopup-box-sign mppopup-box-sign_up pop-reg" style="display: '+ (POPBox.isInitSignIn ? 'none' : 'block') +'">' +
                                '<h3>快速注册漫拍网</h3>' +
                                '<form method="post" action="/sign_up" id="mppopup-box-sing_up-form">' +
                                    '<ul>' +
                                        '<li>' +
                                            '<span class="inputTip">帐号</span>' +
                                            '<input type="text" place-holder="帐号" name="user[username]" class="txt" tabindex="200" />' +
                                        '</li>' +
                                        '<li>' +
                                            '<span class="inputTip">邮箱</span>' +
                                            '<input type="text" place-holder="邮箱" name="user[email]" class="txt" tabindex="201" />' +
                                        '</li>' +
                                        '<li>' +
                                            '<span class="inputTip">密码</span>' +
                                            '<input type="password" place-holder="密码" name="user[password]" class="txt" maxlength="16" tabindex="202" />' +
                                        '</li>' +
                                        '<li>' +
                                            '<input type="button" id="mp-popup-reg-btn" class="pboxtb mppopup-submit-btn" value="" tabindex="203" />' +
                                            '<a href="javascript:void(0);" class="left40_blue fblue sign-in_now" target="_blank">已有帐号，直接登录</a>' +
                                        '</li>' +
                                    '</ul>' +
                                    '<input type="hidden" name="redirect" />' +
                                '</form>' +
                            '</div>' +
                        '</div>' +
                        '<div class="mppopup-box-right mppopup-box-item pop-right">' +
                            '<div class="socials pop-right-con">' +
                                '<p>使用社交帐号登录</p>' +
                                '<a href="/oauth/qzone" class="qzoneLogin" title="用QQ帐号登录">用QQ帐号登录</a>' +
                                '<a href="/oauth/weibo" class="weiboLogin" title="用新浪微博登录">用新浪微博登录</a>' +
                                '<a href="/oauth/renren" class="renrenLogin" title="用人人帐号登录">用人人帐号登录</a>' +
                                '<a href="/oauth/douban" class="doubanLogin" title="用豆瓣帐号登录">用豆瓣帐号登录</a>' +
                            '</div>' +
                        '</div>' +
                        '<b class="pboxtb close" title="关闭"></b>' +
                    '</div>' +
                    '<div class="mppopup-box-outerboder" id="mppopup-box-outer-shade"></div>' +
                    '<div class="mppopup-box-background" id="mppopup-box-shade">' +
                        '<iframe src="about:blank" border="0" frameborder="0" scrolling="no" style="width:100%;height:' + $(document).height() + 'px;background:transparent;"></iframe>' +
                    '</div>'

            
            $('body').append(box);
            if (POPBox.isIE6) {
                $('.mppopup-box,.mppopup-box-outerboder').css({
                    top: document.documentElement.scrollTop + 150
                });
                $(window).scroll(function() {
                    $('.mppopup-box,.mppopup-box-outerboder').css('top', document.documentElement.scrollTop + 150);
                });
            }
        }
    };
    // 隐藏登录框
    POPBox.mppopupBoxRemove = function(){
        $('.mppopup-box,.mppopup-box-background,.mppopup-box-outerboder').remove();
    }
    // 显示登录框
    POPBox.mppopupBoxShow = function() {
        $('.mppopup-box,.mppopup-box-background,.mppopup-box-outerboder').show();
    }
    // 手机、邮箱 blur 校验
    $(document).on('blur', '.mppopup-box input:text,.mppopup-box input:password', function() {
        var _val, _type, _tip, _item, _isSignIn;
        _val  = $.trim($(this).val());
        _tip  = $(this).attr('place-holder');
        _type = $(this).attr('type');
        _item = $(this).attr('name');
        _isSignIn = $(this).parents('form').is('[id=mppopup-box-sing_in-form]');

        $(this).nextAll('div.popup-error').remove();
        // nextAll
        if(_val === ''){
            $(this).prev('span.inputTip').show();
        }
        if(_type === 'password'){
            if(_val === ''){
                if(_isSignIn){
                    $(this).after('<div class="popup-error">请输入密码</div>');
                } else {
                    $(this).after('<div class="popup-error">请设置5-16位英文字母，数字，符号密码</div>');
                }
            } else {
                if(!POPBox.passwordRegexp.test(_val)){
                    if(_isSignIn){
                        $(this).after('<div class="popup-error">密码长度应该在5-16位之间</div>');
                    } else {
                        $(this).after('<div class="popup-error">请a设置5-16位英文字母，数字，符号密码</div>');
                    }
                }
            }
        } else {
            // 如果是其他
            if(_isSignIn){
                if(_val === '' || (!POPBox.emailRegexp.test(_val) && !POPBox.phonePhoneRegexp.test(_val) && !POPBox.usernameRegexp.test(_val))){
                    $(this).after('<div class="popup-error">' + _tip + '</div>');
                }
            } else {
                // 如果是注册并且是用户
                if(_item === 'user[username]') {
                    if(_val === ''){
                        $(this).after('<div class="popup-error">请输入' + _tip + '</div>');
                    } else {
                        if(!POPBox.usernameRegexp.test(_val)){
                            $(this).after('<div class="popup-error">2-10位汉字/字母/数字/_组成</div>');
                        }
                    }
                }
                // 如果是注册并且是邮箱
                if(_item === 'user[email]'){
                    if(_val === ''){
                        $(this).after('<div class="popup-error">请输入' + _tip + '</div>');
                    } else {
                        if(!POPBox.emailRegexp.test(_val)){
                            $(this).after('<div class="popup-error">邮箱格式不正确</div>');
                        }
                    }
                }
            }
        }
    });
    // 保持登录状态 Checkbox
    $(document).on('click', '.mppopup-box .mppopup-box-sign label', function() {
        $(this).toggleClass('checked');
        if ($(this).hasClass('checked')) {
            $(this).parent().find('[name="remember"]').val('on');
        } else {
            $(this).parent().find('[name="remember"]').val('');
        }
    });
    
    // 输入密码的强弱 password input box keyup event
    $(document).on('keyup', '.mppopup-box .mppopup-box-sign_up input:password', function(e) {
        e = e || window.event;
        var _this = $(this),
            _val  = $(this).val();
        $(_this).val($.trim(_val));
        _this.next('span.h_length').remove();
        
        if ($.trim(_this.val()).length > 5) {
            _this.after("<span class='h_length' strenth-for='" + _this.attr("name") + "' style='display: none;'></span>");
        }
        (function() {
            var e = $.trim(_this.val()),
                t = $("[strenth-for='" + _this.attr("name") + "']");
            return POPBox.passwordRegexp.test(e) ? (/^((\d{6,9})|([a-zA-Z]{6,9})|([^\da-zA-Z]{6,9}))$/.test(e) ? t.text("弱") : /^.{6,9}$/.test(e) ? t.text("中") : t.text("强"), t.show(), void 0) : (t.hide(), void 0)
        })();
    });
    // 输入密码按回车就提交
    $(document).on('keyup', '.mppopup-box input:password', function(e) {
        e = e || window.event;
        if (e.keyCode == 13) {
            $(this).parents('form').find('.mppopup-submit-btn').trigger('click');
        }
    });


    // 已有帐号立即登录
    $(document).on('click', '.mppopup-box .sign-in_now', function() {
        $('.mppopup-box .mppopup-box-sign_up').fadeOut(function(){
            $('.mppopup-box .mppopup-box-sign_in').show();
        });
    });
    // 没有帐号，转到注册
    $(document).on('click', '.mppopup-box .sign-up_now', function() {
        $('.mppopup-box .mppopup-box-sign_in').fadeOut(function(){
            $('.mppopup-box .mppopup-box-sign_up').show();
        });
    });

    // 关闭box
    $(document).on('click', '#mppopup-box b.close', function() {
        POPBox.mppopupBoxRemove();
    });
    // esc 关闭box
    $(document).keydown(function(e) {
        e = e || window.event;
        if (e.keyCode === 27) {
            POPBox.mppopupBoxRemove();
        }
    });

    // input box focus
    $(document).on('focus', '.mppopup-box .mppopup-box-sign ul li input.txt', function() {
        $(this).addClass('focus');
        $(this).prev('span.inputTip').hide();
    });
    $(document).on('blur', '.mppopup-box .mppopup-box-sign ul li input.txt', function() {
        $(this).removeClass('focus');
    });
    $(document).on('click', '.mppopup-box span.inputTip', function() {
        $(this).hide().next('input').focus();
    });
    // 登录或注册提交按钮 submit button click
    $(document).on('click', '.mppopup-box .mppopup-submit-btn', function() {
        var _form = $(this).parents('form');
        var _this = $(this);
        _form.find('input.txt').trigger('blur');

        if (_form.find('div.popup-error').length != 0) {
            return false;
        } else {
            if ($(this).is('[id="mppopup-box-btn"]')) {
                $.ajax({
                    dataType: "json",
                    type: "post",
                    url: "/sign_in",
                    data: {
                        username: _form.find('[name="user[username]"]').val(),
                        password: _form.find('[name="user[password]"]').val()
                    },
                    beforeSend: function(){
                        _this.attr('disabled', true);
                    },
                    success: function(result) {
                        if (result.status == -1) {
                            _form.find('[name="user[password]"]').after('<div class="popup-error">' + result.msg + '</div>');
                            setTimeout(function() {
                                _this.attr('disabled', false);
                            }, 2000);
                        } else {
                            _form.submit();
                        }
                    }
                });
            } else {
                _form.find('input[name="redirect"]').val(POPBox.redirectUrl);
                _form.submit();
            }
        }
    });
    // 检查是否已登录
    $(document).on('click', '.popup-login', function() {
        POPBox.redirectUrl  = $(this).attr("data-url") || $(this).attr("href") || 'javascript';
        POPBox.redirectUrl  = POPBox.redirectUrl.indexOf('javascript') == -1 ? POPBox.redirectUrl : window.location.href;
        POPBox.redirectUrl  = encodeURI(POPBox.redirectUrl);
        POPBox.isInitSignIn = !($(this).attr('data-init') === "sign_up");

        $.ajax({
            url: '/validations/is_sign_in',
            success: function(data) {
                if(data == 'true') {
                    window.location.href = POPBox.redirectUrl;
                } else {
                    POPBox.mppopupBox();
                }
            },
            cache: false
        });
        return false;
    });

    // 检测帐号是否存在
    $(document).on('blur', 'input[name="user[username]"], input[name="user[email]"]', function() {
        var _this     = $(this),
            _val      = $.trim($(this).val()),
            _isSignIn = $(this).parents("form").is('[id=mppopup-box-sing_in-form]'),
            _data     = {
                'case_sensitive' : 'true',
                '_'              : Math.random()
            },
            _name     = $(this).attr('name'),
            _url      = _isSignIn ? '/validations/uniqueness' : '/validators/uniqueness'
            _isEmail  = _name === 'user[email]';

        _data[_name] = _val;
        
        if(_val === '' || _this.next('div.popup-error').length != 0){
            return;
        }
        $.ajax({
            url: _url,
            type: 'get',
            data: _data,
            statusCode: {
                404: function() {
                    if (_isSignIn) {
                        _this.nextAll('div.popup-error').remove();
                        _this.after('<div class="popup-error">你所输入的帐号不存在，请 <a href="javascript:void(0);" class="fblue sign-up_now">注册</a></div>');
                    }
                },
                200: function() {
                    if (!_isSignIn) {
                        if(_isEmail){
                            _this.nextAll('div.popup-error').remove();
                            _this.after('<div class="popup-error">该邮箱已存在，请更换邮箱或 <a href="javascript:void(0);" class="fblue sign-in_now">登录</a></div>');
                        } else {
                            _this.nextAll('div.popup-error').remove();
                            _this.after('<div class="popup-error">该帐号已存在，请更换帐号或 <a href="javascript:void(0);" class="fblue sign-in_now">登录</a></div>');
                        }
                        // end
                    }
                }
            }
        });
    });
});