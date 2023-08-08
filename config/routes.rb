Rails.application.routes.draw do
  get 'users/show'
  resources :votes, only: [:new, :create,:edit]
  resources :menus, only: [:new, :create, :edit]
  resources :shops
  resources :categories
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  get "users/show" => "users#show"
  
  root 'shops#index'
  
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
