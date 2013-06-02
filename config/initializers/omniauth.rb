Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, GOOGLE_KEY, GOOGLE_SECRET,
           {
             :scope => "userinfo.email,userinfo.profile,https://www.google.com/reader/api,plus.me,plus.login,blogger",
             :approval_prompt => "auto",
             access_type: "offline"
           }
end
#https://accounts.google.com/o/oauth2/auth?response_type=code&scope=https://www.googleapis.com/auth/userinfo.profile+https://www.google.com/reader/api&redirect_uri=http://www.feedly.com/google.html&access_type=offline&approval_prompt=force&client_id=707616448940.apps.googleusercontent.com&hl=en&from_login=1&as=-274d4a3a9232053e&pli=1&authuser=0ENV[CLIENT_ID], ENV[CLIENT_SECRET]