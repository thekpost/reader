class ApplicationController < ActionController::Base
  protect_from_forgery

  
  include SentientController
  include ActionView::Helpers::DateHelper
  
  private
   
end
