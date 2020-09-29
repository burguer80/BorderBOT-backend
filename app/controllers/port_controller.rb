# frozen_string_literal: true

class PortController < ApplicationController
  def index
    ports = Port.all_with_details
    render json: ports
  end

  def show
    btw = BtwApiService.new
    port_number = params[:id].to_s
    port = btw.recent_pwt(port_number)

    render json: port
  end
end
