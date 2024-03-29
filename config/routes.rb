Rails.application.routes.draw do
  mount Sidekiq::Web, at: "/sidekiq"
  root to: 'ports#index'

  resources :health, only: [:index]
  resources :ports, only: [:index]
  resources :latest_wait_times, only: [:index, :show] #TODO: remove show endpoint since index now support port_ids param

  # Dokku
  get '/check.txt', to: proc {[200, {}, ['it_works']]}
end
