Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'sentiments/index'
    end
  end

  namespace :api do
    namespace :v1 do
      get 'labels/index'
    end
  end

  mount_devise_token_auth_for 'User', at: 'auth'
  namespace :api do
    namespace :v0 do
      resources :ping, only: [:index], constrains: { format: 'json' }
    end
    namespace :v1, defaults: { format: :json } do
      mount_devise_token_auth_for 'User', at: 'auth', skip: [:omniauth_callbacks]
      resources :thoughts, only: [:create]
      resources :labels, only: [:index, :show]
      resources :sentiments, only: [:index]
      resources :history, only: [:index]
    end
  end
end
