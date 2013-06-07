class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  def all
    e = request.env["omniauth.auth"]
    #raise e.to_s
    flag_existing_user = false
    user = User.where(email: e["info"]["email"]).first
    if user.blank?
      user = User.new(email: e["info"]["email"], password: SecureRandom.hex + "1", name: e["info"]["name"], username: e["info"]["name"].downcase.gsub(" ", ""), slug: e["info"]["name"].downcase.gsub(" ", ""))
      user.skip_confirmation!
      user.save
    else
      flag_existing_user = true
    end
    a = user.authentication
    if a.blank?
      Authentication.create(user_id: user.id, provider: "google_oauth2", uid: e["uid"], refresh_token: e["credentials"]["refresh_token"], expires_at: Time.now +  e["credentials"]["expires_at"], token: e["credentials"]["token"],raw_info: e.to_s)
    else
      a.update_attributes(token: e["credentials"]["token"], expires_at: Time.now +  e["credentials"]["expires_at"], raw_info: e.to_s)
    end
    sign_in_and_redirect user
    
    if flag_existing_user
      user.app_keys.each do |ak|
        Delayed::Job.enqueue Dj1.new(ak.id, false)
      end
    else
      Delayed::Job.enqueue Dj4.new(user.id)
    end 
  end

  alias_method :facebook, :all
  alias_method :google_oauth2, :all
  
end