Rails.application.routes.draw do
namespace :api do
  namespace :v0 do
    resources :ping, only: [:index], constrains: { format: 'json' }
  end
end
end
