class Dj4 < Struct.new(:uid)
  
  #SIGN_UP
  
  def perform
    user = User.find(uid)
    user.reauthenticate_google?
    a_json = GRuby::Reader.tags(user.token)
    Tag.import(user, a_json)
    user.reauthenticate_google?
    a_json = GRuby::Reader.subscriptions(user.token)
    AppKey.import(user, a_json)
  end
  
end