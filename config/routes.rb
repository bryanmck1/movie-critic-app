Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    root to: 'devise/sessions#new'
  end

  resources :users, only: [:show, :edit, :update]
  # resources :reviews, only: [:index, :new, :show, :create, :edit, :update, :destroy] 
  resources :movies, only: [:new]
  resources :reviews do 
    collection do 
      get 'search'
    end
  end
end