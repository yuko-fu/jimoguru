Rails.application.routes.draw do
  root "homes#index"
  devise_for :users, controllers: { 
    registrations: 'users/registrations' ,
    passwords: 'users/passwords'
  }
  resources :votes
  resources :menus, only: [:new, :create, :edit]
  resources :shops
  resources :categories
  resources :contacts, only: [:new, :create]
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :users, only: [:show]
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
