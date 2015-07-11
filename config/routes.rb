Rails.application.routes.draw do
  get 'file_data/add_file'
  post 'file_data/download'
  get 'file_data/download_history'
  
  resources :customers
  devise_for :users
  resources :users
  resources :groups do
    member do
      get :member_ship
      get :members
      get :add_members
    end
    collection do
      get :customers
    end
    resources :categories
  end
  resources :categories do
    resources :posts
    resources :documents
  end
  resources :posts do
    resources :comments
  end
  root 'dashboard#index'
end
