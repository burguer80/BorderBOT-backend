# frozen_string_literal: true

class PortsController < ApplicationController
  def index
    render_ports
  end

  private

  def ports
    Ports::All.new.call
  end

  def render_ports
    render json: ports
  end
end
