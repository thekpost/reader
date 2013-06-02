class AuthenticationsController < ApplicationController
  
  before_filter :authenticate_user!
  
  #redirect_to GRuby::Auth.oauth2_url(@dashboard.id.to_s) 
  def revalidate
    @dashboard = Dashboard.find(params[:did])
    redirect_to "https://accounts.google.com/o/oauth2/auth?response_type=code&access_type=offline&approval_prompt=auto&client_id=#{GOOGLE_CLIENTID}&redirect_uri=#{GOOGLE_CALLBACK}&scope=https://www.googleapis.com/auth/analytics.readonly&state=#{@dashboard.id}"
  end
  
  def create
    @user = current_user
    @dashboard = Dashboard.find(params[:state])
    @app = "GA"
    
    @app_key = @dashboard.app_keys.ga.first
    if @app_key.blank?
      @app_key = AppKey.new(user_id: current_user.id, app: "GA", dashboard_id: @dashboard.id)
    end
    @app_key.incoming_channel = "settings"
    @app_key.app_api_token = params[:code]
    @app_key.save 
    
    j = GRuby::Auth.token(params[:code])    
    
    
    if j["refresh_token"].blank?
      refresh_token = AppKey.where("refresh_token is not null").first.refresh_token
    else
      refresh_token = j["refresh_token"]
    end
    
    @app_key.update_attributes(app_password: j["access_token"], refresh_token: refresh_token, expires_at: Time.now + j["expires_in"], error_message: nil)
    
    redirect_to edit_user_dashboard_app_key_path(current_user, @dashboard, id: @app_key.id), notice: "Authentication successful."
  end
  
end