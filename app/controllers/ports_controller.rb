# frozen_string_literal: true

class PortsController < ApplicationController
  def index
    ports_service = PortsService.new
    render json: ports_service.all
  end
end
