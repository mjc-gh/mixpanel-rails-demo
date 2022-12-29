Rails.application.routes.draw do
  # Defines the root path route ("/")
  root "articles#index"

  resources :articles

  devise_for :users

  resources :articles do
    resources :comments, except: :show
  end
end
