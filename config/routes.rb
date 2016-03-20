Rails.application.routes.draw do
  devise_for :users

  namespace :api do
    post 'login', to: 'authentication#login'
    post 'check_token', to: 'authentication#check_token'
    resources :discounts, only: :index
    resources :products do
      collection do
        get :last_update
        get :available
      end
    end
    resources :salesmen do
      collection do
        get :clients
        get :orders
      end
    end
    resources :orders
  end

  resources :clients do
    member do
      patch 'change_status'
    end
  end

  resources :orders do
    member do
      patch 'review'
    end
  end

  resources :products, only: [:index, :show] do
    collection do
      get 'upload_file'
      patch 'massive_process'
    end
  end

  resources :discounts, except:[:show]

  resources :users do
    member do
      get :edit_password
      patch :update_password
      patch :change_status
    end
  end

  resources :zones

  get 'saint/pending'
  post 'saint/sincronize'
  get 'sales' => 'home#to_sales'
  get 'download/:filename' => 'home#download', as: :download_file

  devise_scope :user do
    unauthenticated do
      root 'devise/sessions#new'
    end
    authenticated :user  do
      root 'home#index', as: :root_index
    end
  end
end
