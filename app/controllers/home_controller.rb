class HomeController < ApplicationController
    before_action  :redirect_root, except: :top
    def top
      if session[:user_id]
        redirect_to("/posts/index")
    end
     
    end
  end
  
  private
  
  