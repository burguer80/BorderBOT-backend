class HealthController < ApplicationController
  def index
    response = {api: 'OK'}
    render json: response, status: :ok
  end
end
