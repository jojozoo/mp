class My::SetsController < My::ApplicationController
    def index
        redirect_to action: :basic
    end

    def basic
        
    end

    def avatar
        
        if request.post?
            current_user.update_attributes!(avatar: params[:filedata])
            width, height = Paperclip::Geometry.from_file(current_user.avatar.path).to_s.split('x').map(&:to_i) rescue [300, 300]
            data = {
                width: width,
                height: height,
                size: current_user.avatar.size,
                url: current_user.avatar.url
            }
            
            render json: data.to_json and return
        end
    end

    def cut
        system ("convert -crop #{params[:w]}x#{params[:h]}+#{params[:x]}+#{params[:y]} #{current_user.avatar.path} #{current_user.avatar.path}")
        current_user.update_attributes(avatar: File.open(current_user.avatar.path))
        redirect_to action: :avatar
    end

    def update
        p = params[:user].slice(:mobile, :realname, :province, :city, :gender, :site, :domain, :profession, :duty, :warrant, :resume)
        current_user.update_attributes(p)
        redirect_to action: :basic
    end

    def update_pass
        if current_user.valid_password?(params[:user][:password])
            if current_user.update_attributes password: params[:user][:newpassword]
                flash[:notice] = '密码修改成功'
            else
                flash[:notice] = '密码修改失败, 请联系管理员'
            end
        else
            flash[:notice] = '原密码输入错误'
        end
        redirect_to action: :security
    end

    def security
        
    end

    def privacy
        
    end

    def push
        # @accept = current_user.accept
        # if request.post?
        #     @accept.update_attributes(params[:accept])
        #     flash[:notice] = '数据修改成功！'
        #     redirect_to action: :push
        # end
        
    end

    def dy
        
    end

    def bg
        
    end
    
    def others
    end
end