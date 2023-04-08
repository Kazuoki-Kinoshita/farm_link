Rails.application.routes.draw do
  get 'farmers/index'
  get 'farmers/show'
  get 'farmers/new'
  get 'farmers/edit'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  root 'generals#index'
  resources :generals, only: [:new, :create, :show, :edit, :update, :destroy]
  resources :farmers
  
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end