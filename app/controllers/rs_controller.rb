class RsController < ApplicationController
    def index
        @star = Push.where(channel: '漫拍之星').last
        @yts  = Push.where(channel: '每日一图').order('id desc').limit(4)
        @photographers = Push.where(channel: '推荐摄影师').order('id desc').limit(3)
    end
end