class PwtController < ApplicationController
  def show
    if valid_port
      port = pwt_service.recent_pwt(port_number_param)
      render json: port
    else
      render_404
    end
  end

  private

  def port_service
    PortsService.new
  end

  def pwt_service
    BtwApiService.new
  end

  def port_number_param
    params[:id].to_s
  end

  def valid_port
    port_service.valid(port_number_param)
  end
end
