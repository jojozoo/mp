class Admin::SessionsController < Admin::ApplicationController
  
  def index
    @users = User.paginate(:page => params[:page], per_page: 3).order(params[:order])
  end

  def info
    @info = YAML.load_file("config/datas/site.yml").symbolize_keys
    if request.post?
      info = params[:info].slice(:name, :title, :key_words, :description, :server_name, :admin_mail, :user_mail).to_yaml
      File.open('config/datas/site.yml', 'wb'){|f| f.write(info)}
      redirect_to '/admin/info'
    end
  end

  def log
    params[:day]
  end
  
end

