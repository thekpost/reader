class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :user_is_the_one_who_is_logged_in
  
  include SentientController
  include ActionView::Helpers::DateHelper
  
  private
  
  def user_is_the_one_who_is_logged_in
    if !current_user.blank?
      @user = current_user      
    end
  end
   
end
