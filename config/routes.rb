Rails.application.routes.draw do
  get 'home/index'
  get 'recipes/index'
  get 'recipes/show'
  get 'recipes/new'
  get 'recipes/edit'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :recipes
  root 'home#index'
  # root 'recipes#index'
  #  root to: redirect('/users/sign_up')
end
