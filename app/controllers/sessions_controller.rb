class SessionsController < Devise::SessionsController
  
  def new
    @email_preset = params[:email_preset]
    super
  end
  
  def create
    super
    #self.resource = warden.authenticate!(auth_options)
    #set_flash_message(:notice, :signed_in) if is_navigational_format?
    #sign_in(resource_name, resource)
    #respond_with resource, :location => after_sign_in_path_for(resource)
  end
  
end
