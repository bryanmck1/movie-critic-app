Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    root to: 'devise/sessions#new'
  end

  resources :users, only: [:show, :edit, :update]
  resources :reviews, only: [:index, :new, :show, :create]
  resources :movies, only: [:new]
end