class StaticPagesController < ApplicationController
  
  def index
    if user_signed_in?
      @user = current_user
      redirect_to user_path(current_user)
    else
      render "index"
    end
  end
  
  def developer
  end
  
  def about
  end
  
  def faqs
  end
  
end
