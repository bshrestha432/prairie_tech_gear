Rails.application.routes.draw do
  # Health check and PWA routes
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Devise authentication routes with friendly URLs
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    sign_up: 'register',
    password: 'reset'
  }, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # ActiveAdmin routes
  ActiveAdmin.routes(self)

  # Main routes
  root "home#index"

  # Product catalog routes
  resources :categories, only: [:index, :show] do
    resources :products, only: [:index]
  end

  resources :products, only: [:index, :show] do
    collection do
      get 'search'
    end
    member do
      post 'add_to_cart'
    end
    resources :reviews, only: [:create]
  end

  # Shopping cart routes
  resource :cart, only: [:show, :update, :destroy] do
    member do
      delete 'remove_item/:product_id', to: 'carts#remove_item', as: 'remove_item'
      post 'checkout'
    end
  end

  # Order processing routes
  resources :orders, only: [:index, :show, :create] do
    collection do
      get 'checkout'
      post 'process_payment'
    end
  end

  # User account routes
  resource :profile, only: [:show, :edit, :update]
  get 'my_orders', to: 'profiles#orders'

  # Static pages
  get 'about', to: 'pages#about'
  get 'contact', to: 'pages#contact'
  get 'terms', to: 'pages#terms'
  get 'privacy', to: 'pages#privacy'

  # Error handling
  match '/404', to: 'errors#not_found', via: :all
  match '/500', to: 'errors#internal_error', via: :all

  # Admin-only API endpoints (if needed)
  namespace :admin do
    resources :dashboard, only: [:index]
  end
end