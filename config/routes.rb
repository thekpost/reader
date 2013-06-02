RedFeed::Application.routes.draw do
  
  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks", sessions: "sessions", :registrations => "registrations"} do
    get '/auth/google_oauth2/callback', to: 'omniauth_callbacks#all'
    get "sign_in", :to => "sessions#new", as: :sign_in
    get "sign_up", :to => "devise/registrations#new", as: :sign_up
    get "sign_out", :to => "devise/sessions#destroy", as: :sign_out
  end
    
  resources :users do
    resources :feed_entries
    resources :app_keys do
      get "request_fetch", on: :member
    end
  end
  
  #ROOT
  root :to => 'static_pages#index'
  
end
