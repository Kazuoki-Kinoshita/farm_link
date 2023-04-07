Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  root 'generals#new'
  resources :users, only: [] do
    resource :general, only: [:new, :create, :show, :edit, :update]
  end
  resources :generals
  
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end