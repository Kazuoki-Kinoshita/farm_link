Rails.application.routes.draw do
  get 'tops/index'
  
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    post 'users/guest_admin_sign_in', to: 'users/sessions#guest_admin_sign_in'
    post 'users/guest_farmer_nil_sign_in', to: 'users/sessions#guest_farmer_nil_sign_in'
    post 'users/guest_farmer_present_sign_in', to: 'users/sessions#guest_farmer_present_sign_in'
    post 'users/guest_general_nil_sign_in', to: 'users/sessions#guest_general_nil_sign_in'
    post 'users/guest_general_present_sign_in', to: 'users/sessions#guest_general_present_sign_in'
  end

  root 'tops#index'
  resources :tops, only: [:index]
  resources :users, only: [:show, :index]
  resources :relationships, only: [:create, :destroy]
  resources :users, only: [:show] do
    get "follows", on: :member
  end

  resources :generals, only: [:new, :create, :show, :edit, :update]
  resources :farmers, only: [:index, :new, :create, :show, :edit, :update] do
    get "overview", on: :member
  end
  resources :posts
  resources :experiences do
    resources :schedules, only: [:create, :edit, :update, :destroy]
  end
  resources :conversations do
    resources :messages
  end
  
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end