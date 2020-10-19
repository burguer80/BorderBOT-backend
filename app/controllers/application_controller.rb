class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  def render_404
    render nothing: true, status: 404
  end

  def port_number_param
    params[:id].to_s
  end

  def valid_port
    render_404 unless PortsService.valid(port_number_param)
  end

  def pwt_service
    BtwApiService.new
  end
end
