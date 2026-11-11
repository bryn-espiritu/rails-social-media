Rails.application.routes.draw do
  resources :friends
  resources :friend_requests
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth' }

  resources :posts do
    resources :comments
    resource :like, only: [:create, :destroy]
  end

  resources :groups
  root "posts#index"
end
