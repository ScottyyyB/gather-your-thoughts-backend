Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  namespace :api do
    namespace :v0 do
      resources :ping, only: [:index], constrains: { format: 'json' }
    end
    namespace :v1, defaults: { format: :json } do
      mount_devise_token_auth_for 'User', at: 'auth', skip: [:omniauth_callbacks]
      resources :entries, only: [:create, :show, :index, :destroy, :update]
      resources :labels, only: [:index, :show]
      get '/sentiments/statistics', to: 'sentiments#statistics'
      resources :sentiments, only: [:index, :show]
      resources :history, only: [:index]
      resources :activity, only: [:index]
    end
  end
end
