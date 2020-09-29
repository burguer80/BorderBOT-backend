Rails.application.routes.draw do
  mount Sidekiq::Web, at: "/sidekiq"
  root to: 'borders#index'

  resources :health, only: [:index, :show]
  resources :port, only: [:show]
  resources :pwt, only: [:show]


  # Dokku
  get '/check.txt', to: proc {[200, {}, ['it_works']]}
end
