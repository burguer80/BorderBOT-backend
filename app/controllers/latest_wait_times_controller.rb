class LatestWaitTimesController < ApplicationController
  before_action :valid_port, only: [:show]

  def show
    port = LatestPortWaitTimesService.find(port_number_param)
    render json: port
  end
end
