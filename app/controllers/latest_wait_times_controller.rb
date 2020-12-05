class LatestWaitTimesController < ApplicationController
  before_action :valid_port, only: [:show]

  def show
    render_lwt_response
  end

  private

  def port
    Ports::FindByPortNumber.new(port_number_param).call
  end

  def port_number_param
    params[:id].to_s
  end

  def render_lwt_response
    render json: port
  end

  def valid_port
    render_404 unless Ports::NumberValid.new.call(port_number_param)
  end
end
