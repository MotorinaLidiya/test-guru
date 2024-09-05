Rails.application.routes.draw do
  root 'tests#index'

  resources :tests, only: [] do
    resources :questions
  end

  get "/tests/:test_id/questions/:id", to: "questions#show"
end
