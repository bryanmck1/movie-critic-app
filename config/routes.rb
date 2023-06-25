Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    root to: 'devise/sessions#new'
  end

  resources :users, only: [:show, :edit, :update]
  resources :movies, only: [:new]
  resources :reviews do 
    collection do 
      get 'search'
      get 'filter'
    end
  end
end