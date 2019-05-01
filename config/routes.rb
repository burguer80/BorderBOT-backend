Rails.application.routes.draw do
  get 'port/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'pull_data', to: 'borders#pull_data'
  get 'ports', to: 'port#index'
  get 'borders_list', to: 'borders#list'
  root to: 'borders#index'
end
