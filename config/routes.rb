Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  namespace :api do
    namespace :v0 do
      resources :ping, only: [:index], constrains: { format: 'json' }
    end
    namespace :v1, defaults: { format: :json } do
      resources :thoughts, only: [:create]
    end
  end
end
