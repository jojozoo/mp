

$(function() {

    // href data-url 登录后的跳转地址 data-init
    var POPBox = {
        isIE6: false,
        hostname: window.location.host,
        isInitSignIn: true,
        isChecked: true,
        emailRegexp: /^(?:\w+\.?)*\w+@(?:\w+\.)+\w+$/,
        phonePhoneReg: /^(([0\+]\d{2,3}-)?(0\d{2,3})-)?(\d{7,8})(-(\d{3,}))?$/,
        usernameRegexp: /[\w\.\@\u4e00-\u9fa5]{2,}/,
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
            box = '<div class="mppopup-box" id="mppopup-box" data-target="' + POPBox.redirectUrl + '">' +
                        '<div class="mppopup-box-left mppopup-box-item pop-left">' +
                            '<div class="mppopup-box-sign mppopup-box-sign_in pop-login" style="display: '+ (POPBox.isInitSignIn ? 'block' : 'none') +'">' +
                                '<h3>立即登录</h3>' +
                                '<form method="post" action="/sign_in" id="mppopup-box-sing_in-form">' +
                                    '<ul>' +
                                        '<li>' +
                                            '<span class="inputTip">输入帐号/邮箱/手机</span>' +
                                            '<input type="text" place-holder="正确帐号邮箱或手机" name="account[username]" class="txt" regtype="notnull,username,email,phone" id="mp-login-username" tabindex="100" />' +
                                        '</li>' +
                                        '<li>' +
                                            '<span class="inputTip">输入登录密码</span>' +
                                            '<input type="password" place-holder="密码" name="account[password]" class="txt" regtype="notnull,password" maxlength="16" tabindex="101" />' +
                                        '</li>' +
                                        '<li>' +
                                            '<input type="hidden" name="remember" value="on" />' +
                                            '<input type="hidden" name="return_to" value="' + POPBox.redirectUrl + '" />' +
                                            '<label class="pboxtb checked">保持登录状态</label>' +
                                            '<a href="/forgot" class="get-back-password" target="_blank" title="找回密码">找回密码</a>' +
                                        '</li>' +
                                        '<li>' +
                                            '<input type="button" id="mppopup-box-btn" class="pboxtb mppopup-submit-btn" value="" tabindex="102" />' +
                                            '<a href="http://mpwang.cn/sign_up" class="fblue reg-now" target="_blank">没有帐号，立即注册</a>' +
                                        '</li>' +
                                    '</ul>' +
                                '</form>' +
                            '</div>' +
                            '<div class="mppopup-box-sign mppopup-box-sign_up pop-reg" style="display: '+ (POPBox.isInitSignIn ? 'block' : 'none') +'">' +
                                '<h3>快速注册漫拍网</h3>' +
                                '<form method="post" action="/sign_up" id="mppopup-box-sing_up-form">' +
                                    '<ul>' +
                                        '<li>' +
                                            '<span class="inputTip">帐号</span>' +
                                            '<input type="text" place-holder="帐号" name="account[username]" class="txt" regtype="notnull,username" tabindex="200" />' +
                                        '</li>' +
                                        '<li>' +
                                            '<span class="inputTip">邮箱</span>' +
                                            '<input type="text" place-holder="正确邮箱" name="account[email]" class="txt" regtype="notnull,email" id="mp-reg-username" tabindex="201" />' +
                                        '</li>' +
                                        '<li>' +
                                            '<span class="inputTip">密码</span>' +
                                            '<input type="password" place-holder="密码" name="account[password]" class="txt" regtype="notnull,password" maxlength="16" tabindex="202" />' +
                                        '</li>' +
                                        '<li>' +
                                            '<input type="button" id="mp-popup-reg-btn" class="pboxtb mppopup-submit-btn" value="" tabindex="203" />' +
                                            '<a href="http://mpwang.cn/sing_in" class="fblue login-now" target="_blank">已有帐号，直接登录</a>' +
                                        '</li>' +
                                    '</ul>' +
                                    '<input type="hidden" name="landing_page" value="popup" />' +
                                    '<input type="hidden" name="parameters" />' +
                                    '<input type="hidden" name="keyword" />' +
                                    '<input type="hidden" name="data-target" />' +
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
    // 前端校验
    POPBox.validItem = function(){

    }

    
    function regInput(obj, value, msg, type) {
        var bFail = false;
        switch (type) {
            case 'notnull':
                bFail = (value !== '');
                break;
            case 'email':
                bFail = POPBox.emailRegexp.test(value);
                break;
            case 'chinese':
                var chineseReg = /^\s*([\u4E00-\u9FA5]{2,5}(?:·[\u4E00-\u9FA5]{2,5})*|[a-zA-Z]{2,20}(\s+[a-zA-Z]{2,20})+)\s*$/;
                var chineseReg1 = /^\s*([\u4E00-\u9FA5]{2,5}(?:·[\u4E00-\u9FA5]{2,5})*|[a-zA-Z][\sa-zA-Z]{3,63})\s*$/;
                bFail = chineseReg.test(value) && chineseReg1.test(value);
                break;
            case 'password':
                bFail = !POPBox.passwordRegexp.test(value);
                break;
        }
        obj.next('div.popup-error').remove();
        if (!bFail) {
            if (obj.val() === '') {
                obj.prev('span.inputTip').show();
            }
            if(obj.attr('type') === 'password'){
                if(value === '' && type === 'notnull'){
                    if(obj.parents("form").is('[id=mppopup-box-sing_up-form]')){
                        obj.after('<div class="popup-error">请输入6-16位英文字母，数字，符号密码</div>');
                    } else {
                        obj.after('<div class="popup-error">请输入密码</div>');
                    }
                }
                if(value !== '' && type === 'password'){
                    if(obj.parents("form").is('[id=mppopup-box-sing_up-form]')){
                        obj.after('<div class="popup-error">请输入6-16位英文字母，数字，符号密码</div>');
                    } else {
                        obj.after('<div class="popup-error">密码长度应该在6-16位之间</div>');
                    }
                }
            } else {
                obj.after('<div class="popup-error">请输入' + msg + '</div>');
            }
        }
    }
    // 手机、邮箱 校验有一定的问题
    $(document).on('blur', '.mppopup-box input:text,.mppopup-box input:password', function() {
        var aReg = $(this).attr('regtype').split(',');
        $(this).nextAll('div.popup-error').remove();
        for (var i = 0; i < aReg.length; i++) {
            regInput($(this), $.trim($(this).val()), $(this).attr('place-holder'), aReg[i]);
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
    $('body').on('keyup', '#mppopup-box input:password', function(e) {
        e = e || window.event;
        if (e.keyCode == 13) {
            $(this).parents('form').find('.mppopup-submit-btn').trigger('click');
        }
    });


    // 已有帐号立即登录
    $('body').on('click', '#mppopup-box .login-now', function() {
        return frameMove('#mppopup-box .pop-reg', '#mppopup-box .pop-login', 'login');
    });
    // 没有帐号，转到注册
    $('body').on('click', '#mppopup-box .reg-now', function() {
        return frameMove('#mppopup-box .pop-login', '#mppopup-box .pop-reg', 'reg');
    });


    $(document).on('click', '#mppopup-box b.close', function() {
        POPBox.mppopupBoxRemove();
    });
    //esc hide the box
    $(document).keydown(function(e) {
        e = e || window.event;
        if (e.keyCode === 27) {
            POPBox.mppopupBoxRemove();
        }
    });

    //input box focus
    $('body').on('focus', '#mppopup-box .mppopup-box-sign ul li input.txt', function() {
        $(this).addClass('focus');
        $(this).prev('span.inputTip').hide();
    });
    $('body').on('blur', '#mppopup-box .mppopup-box-sign ul li input.txt', function() {
        $(this).removeClass('focus');
    });
    $('body').on('click', '#mppopup-box span.inputTip', function() {
        $(this).hide().next('input').focus();
    });

    // 注册、登录移动
    function frameMove(target1, target2, type) {
        $(target1).fadeOut(function() {
            $(target2).show();
        });
        return false;
    }
    // 
    if (!window.__$) {
        window.__$ = $;
    }
    // submit button click
    $('body').on('click', '#mppopup-box .mppopup-submit-btn', function() {
        var $thisForm = $(this).parents('form');
        var $this = $(this);
        var canSubmit = true;
        var returnTarget = $('#mppopup-box').attr('data-target');
        $thisForm.find('input.txt[name!="account[username]"]').trigger('blur');

        if ($thisForm.find('[name="account[username]"]').next('div.popup-error').length == 0) {
            $thisForm.find('[name="account[username]"]').trigger('blur');
        }
        if ($thisForm.find('div.popup-error').length != 0) {
            return false;
        } else {
            if ($(this).is('[id="mppopup-box-btn"]')) {
                $(this).attr('disabled', true);
                __$.ajax({
                    dataType: "json",
                    type: "post",
                    url: "http://mpwang.cn/index/login",
                    data: {
                        "account[username]": $thisForm.find('[name="account[username]"]').val(),
                        "account[password]": $thisForm.find('[name="account[password]"]').val()
                    },
                    success: function(result) {
                        if (result.status == -1) {
                            $thisForm.find('[name="account[password]"]').after('<div class="popup-error">' + result.msg + '</div>');
                            setTimeout(function() {
                                $this.attr('disabled', false);
                            }, 2000);
                        } else {
                            //window.location.href = returnTarget;
                            $thisForm.submit();
                        }
                    }
                });
            } else {
                $('#mppopup-box .pop-reg input[name="parameters"]').val(window.location.search.substring(1));
                $thisForm.find('input[name="data-target"]').val(returnTarget);
                if ($('meta[name="Keywords"]')) {
                    $('#mppopup-box .pop-reg input[name="keyword"]').val($('meta[name="Keywords"]').attr('content'));
                }
                $thisForm.submit();
            }
        }
    });
    // 检查是否已登录
    $(document).on('click', '.popup-login', function() {
        var _this = $(this);
        // 如果是javascript:void(0);类型的a,应看有没有data-url或者window.location.reload()
        // 暂定:含有popup-login的必须是a,并且有href
        // 应该写个函数获取redirectUrl:包含不是a的情况或a href='javascript:void(0);'的情况
        var redirectUrl = $(this).attr("href") || $(this).attr("data-url") || window.location.href;
        __$.ajax({
            url: '/validations/is_sign_in',
            success: function(data) {
                if(!data['error']) {
                    window.location.href = redirectUrl;
                } else {
                    POPBox.redirectUrl  = encodeURI(redirectUrl);
                    POPBox.isInitSignIn = !(_this.attr('data-init') === "sign_up");
                    POPBox.mppopupBox();
                }
            },
            cache: false
        });
        return false;
    });

    // 检测帐号是否存在
    $('body').on('blur', 'input[name="account[username]"]', function() {
        var $this = $(this),
            thisVal = $.trim($(this).val());
        if (thisVal !== '' && $this.next('div.popup-error').length == 0) {
            __$.ajax({
                // /validators/uniqueness?case_sensitive=true&user%5Busername%5D=%E6%9C%B1%E6%99%93%E6%AD%A6
                url: '/validators/uniqueness',
                type: 'get',
                data: {
                    username: $this.val()
                },
                statusCode: {
                    200: function() {
                        $('input[name="account[username]"]').prev('span.inputTip').hide().end().val($this.val()).next('div.popup-error').remove();
                        if ($this.attr('id') === 'mp-login-username') {
                            if ($this.next('div.popup-error').length !== 0) {
                                $this.next('div.popup-error').html('你所输入的帐号不存在，请 <a href="javascript:void(0);" class="fblue reg-now">注册</a>');
                            } else {
                                $this.after('<div class="popup-error">你所输入的帐号不存在，请 <a href="javascript:void(0);" class="fblue reg-now">注册</a></div>');
                            }
                        }
                    },
                    201: function() {
                        $('input[name="account[username]"]').prev('span.inputTip').hide().end().val($this.val()).next('div.popup-error').remove();
                        if ($this.attr('id') === 'mp-reg-username') {
                            if ($this.next('div.popup-error').length !== 0) {
                                $this.next('div.popup-error').html('该帐号已存在，请更换帐号或 <a href="javascript:void(0);" class="fblue login-now">登录</a>');
                            } else {
                                $this.after('<div class="popup-error">该帐号已存在，请更换帐号或 <a href="javascript:void(0);" class="fblue login-now">登录</a></div>');
                            }
                        }
                    }
                }
            });
        }
    });
});