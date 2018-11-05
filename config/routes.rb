Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get ' pulldata', 'bordoers#pull_data'

  get 'pull_data', to: 'borders#pull_data'
  root to: 'borders#index'
end
