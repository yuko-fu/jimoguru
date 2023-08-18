Rails.application.routes.draw do
  root "homes#index"
  resources :contacts, only: [:new, :create]
  devise_for :users, controllers: { 
    registrations: 'users/registrations' ,
    passwords: 'users/passwords'
  }
  resources :votes
  resources :menus
  resources :shops
  resources :categories
  resources :contacts, only: [:new, :create]
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :users, only: [:show] do
    member do
      get :confirm_withdraw
      patch :withdraw
    end
  end
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
    post 'users/guest_admin_sign_in', to: 'users/sessions#guest_admin_sign_in'
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
