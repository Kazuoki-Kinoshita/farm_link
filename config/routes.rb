Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  resources :users, only: [:show, :index]
  resources :relationships, only: [:create, :destroy]

  root 'farmers#index'
  resources :generals, only: [:new, :create, :show, :edit, :update]
  resources :farmers, only: [:index, :new, :create, :show, :edit, :update] do
    get 'overview', on: :member
  end
  resources :posts
  resources :experiences
  resources :conversations do
    resources :messages
  end
  
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end