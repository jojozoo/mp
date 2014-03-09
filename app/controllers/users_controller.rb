class UsersController < ApplicationController

    def profile
        
    end

    def show

    end

    def show
        @user = User.find(params[:id])
    end
    
end