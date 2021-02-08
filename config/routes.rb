Rails.application.routes.draw do
  root to: "users#index"
  resources :users
  resources :pair_users
  resource :session, only: %i[show create]
end
