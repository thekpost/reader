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
  
  def developer
    render layout: "empty"
  end
  
  def about
    render layout: "empty"
  end
  
  def faqs
    render layout: "empty"
  end
  
end
