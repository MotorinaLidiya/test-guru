Rails.application.routes.draw do
  resources :about, only: :index do
    get 'author', on: :collection
  end
end
