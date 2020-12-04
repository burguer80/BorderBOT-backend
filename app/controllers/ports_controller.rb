# frozen_string_literal: true

class PortsController < ApplicationController
  def index
    render_ports
  end

  private

  def ports
    PortsService.all
  end

  def render_ports
    render json: ports
  end
end
