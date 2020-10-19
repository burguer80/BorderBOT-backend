# TODO: remove all the implementation related with this end point

class PwtController < ApplicationController
  before_action :valid_port, only: [:show]

  def show
    port = pwt_service.recent_pwt(port_number_param)
    render json: port
  end
end
