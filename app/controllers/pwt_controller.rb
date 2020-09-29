class PwtController < ApplicationController
  def show
    btw = BtwApiService.new
    port_number = params[:id].to_s
    port = btw.recent_pwt(port_number)

    render json: port
  end
end
