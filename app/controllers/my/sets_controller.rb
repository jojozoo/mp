class My::SetsController < My::ApplicationController
    def index
        redirect_to action: :basic
    end

    def basic
        # render '/my/shared/template'
    end

    def avatar
        # render '/my/shared/template'
        if request.post?
            current_user.update_attributes!(avatar: params[:Filedata])
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

    def security
        # render '/my/shared/template'
    end

    def privacy
        # render '/my/shared/template'
    end

    def push
        # render '/my/shared/template'
    end

    def dy
        # render '/my/shared/template'
    end

    def bg
        # render '/my/shared/template'
    end
    
    def others
    end
end