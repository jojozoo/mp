class CheckController < ApplicationController

  def register
    if User.where(params[:tag] => params[:key]).blank?
        render text: 'success'
    else
        render text: '账户已存在'
    end
  end

end
