class SystemController < ApplicationController
    

    def show
        # sleep(1)
        send_path = "public/system/#{params[:class]}/#{params[:id]}/#{params[:style]}/#{params[:random]}.#{params[:format]}"
        if params[:class].eql?('images') and params[:style] and params[:style].eql?('original')
            redirect_to '/404' and return
        end
        send_file send_path, type: 'image/jpeg', disposition: 'inline'
    end
end