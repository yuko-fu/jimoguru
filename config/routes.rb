Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :votes
  resources :menus, only: [:new, :create, :edit]
  resources :shops
  resources :categories
  resources :contacts, only: [:new, :create]
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :users, only: [:show]
  root 'shops#index'
  
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
