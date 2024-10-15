Rails.application.routes.draw do
  root 'tests#index'

  devise_for :users, controllers: { sessions: 'sessions' }, path: :gurus, path_names: { sign_in: :login, sign_out: :logout }

  resources :tests, only: :index do
    member do
      post :start
    end
  end

  resources :test_passages, only: %i[show update] do
    member do
      get :result
      post :gist
    end

    resources :feedbacks, only: %i[new create]
  end

  namespace :admin do
    resources :tests do
      patch :update_inline, on: :member

      resources :questions, shallow: true, except: :index do
        resources :answers, shallow: true, except: :index
      end
    end

    resources :categories
    resources :gists, only: %i[index create]
    resources :badges, only: %i[index new create edit update destroy]
  end

  namespace :api do
    resources :test_passages, only: [] do
      post :save_time, on: :member
    end
  end

  resources :gists, only: :create

  resources :badges, only: :index do
    get 'my', on: :collection
  end
end
