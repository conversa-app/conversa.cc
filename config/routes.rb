require 'sidekiq/web'

Rails.application.routes.draw do
  root to: 'conversations#index'
  get 'login' => 'access#new'
  get 'reset/:token', to: 'access#reset_password', as: 'reset_password'
  get 'settings', to: 'users#edit', as: 'settings'
  get 'validation_failed' => 'users#validation_failed'

  delete 'logout' => 'access#destroy'

  resources :conversations do
    member do
      get :delete
    end
  end

  resource :access, controller: 'access', except: %i[show edit update] do
    member do
      get :menu
      get :forgot_password
      put :send_reset_token
      get :get_password_idea
      get :reset_password
      put :update_password
    end
  end

  resources :users do
    collection do
      get :resend_validation_email
    end
  end

  namespace :staff do
    mount Sidekiq::Web => '/sidekiq', :constraints => AdminConstraint.new

    root to: 'access#menu'
    get 'login' => 'access#new'
    delete 'logout' => 'access#destroy'
    get 'menu' => 'access#menu'
    resource :access, controller: 'access', except: %i[show edit update] do
      member do
        get :menu
        get :forgot_password
        put :send_reset_token
        get :get_password_idea
        get :reset_password
        put :update_password
      end
    end

    resources :admins, except: :show do
      member do
        get :delete
      end
    end

    resources :users, only: :index do
      member do
        patch :enable
      end
    end
  end
end