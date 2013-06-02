class StaticPagesController < ApplicationController
  
  def index
    r = request.env["HTTP_REFERER"]    
    if user_signed_in?
      @user = current_user
      redirect_to user_path(current_user)
    else
      render "index", layout: "empty"
    end
  end
  
end
