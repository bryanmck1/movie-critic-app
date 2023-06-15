Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    root to: 'devise/sessions#new'
  end

  resources :users, only: [:show, :edit, :update]
  resources :reviews, only: [:index, :new]
end