class SitesController < ApplicationController

    def index
        redirect_to action: :about
    end

    # 意见反馈
    def create
        flash[:notice] = "反馈已收到,我们会尽快回复您!"
        @fb = Feedback.new(params[:feedback])
        @fb.save
        redirect_to action: :feedback
    end

    # 关于我们
    def about
        @title = '漫拍网-关于我们'
    end

    # 联系方式
    def contact
        @title = '漫拍网-联系方式'
    end

    # 对外合作
    def out
        @title = '漫拍网-对外合作'
    end

    # 合作伙伴
    def link
        @title = '漫拍网-合作伙伴'
    end

    # 手机客户端
    def mobile
        @title = '漫拍网-手机客户端'
    end

    # 招聘
    def job
        @title = '漫拍网-招聘'
    end

    # 服务条款
    def term
        @title = '漫拍网-服务条款'
    end

    # 隐私政策
    def private
        @title = '漫拍网-隐私政策'
    end

    # 意见反馈
    def feedback
        @title = '漫拍网-意见反馈'
    end

    # 错误页面跳转地址
    def error
    end
end
