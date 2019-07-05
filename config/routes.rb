Rails.application.routes.draw do

  mount Sidekiq::Web, at: "/sidekiq"
  root to: 'borders#index'

  # Dokku
  get '/check.txt', to: proc {[200, {}, ['it_works']]}
end
