Rails.application.routes.draw do
  root 'tests#index'

  resources :tests, only: [] do
    resources :questions, shallow: true
  end
end
