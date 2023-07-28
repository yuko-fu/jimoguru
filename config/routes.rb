Rails.application.routes.draw do
  resources :vote_photos
  resources :votes
  resources :menus
  resources :shops
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root 'blogs#index'
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
