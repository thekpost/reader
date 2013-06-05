class Authentication < ActiveRecord::Base

  #GEMS USED
  #ACCESSORS
  attr_accessible :expires_at, :provider, :raw_info, :refresh_token, :token, :uid, :user_id
  
  #ASSOCIATIONS
  belongs_to :user

  #VALIDATIONS
  #CALLBACKS
  #SCOPES
  #CUSTOM SCOPES
  #OTHER METHODS
  
  def reauthenticate_google?
    if Time.now - self.expires_at > 0
      j = GRuby::Auth.refresh(self.refresh_token)
      self.update_attributes(token: j["access_token"], expires_at: Time.now + j["expires_in"])
    end
    true
  end
  
  #JOBS
  #PRIVATE
  
  private
  
end
