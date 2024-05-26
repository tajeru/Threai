class ApplicationController < ActionController::Base
    before_action :set_current_user



    private 
  
    def set_current_user
      if session[:user_id]
        @current_user = User.find_by(id: session[:user_id])
      else
        @current_user = nil
      end
    end
  
    def redirect_root
      if @current_user.nil?
        redirect_to("/")
      end
    end
  end