Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  devise_scope :user do
    root to: 'devise/sessions#new'
    get 'user/profile/edit' => 'registrations#profile', as: "registrations_profile_edit"
  end

  resources :users, only: [:show]
  resources :movies, only: [:new]
  resources :reviews do 
    collection do 
      get 'search'
      get 'filter'
    end
  end
end