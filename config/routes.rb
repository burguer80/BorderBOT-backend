Rails.application.routes.draw do
  get 'port/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'pull_data', to: 'borders#pull_data'
  get 'push_data', to: 'borders#push_data'
  get 'ports', to: 'port#index'
  root to: 'borders#index'

  # Dokku
  get '/check.txt', to: proc {[200, {}, ['it_works']]}
end
