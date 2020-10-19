# frozen_string_literal: true

class PortsController < ApplicationController
  def index
    render json: PortsService.all
  end
end
