# frozen_string_literal: true

class PortController < ApplicationController
  def index
    @ports = Port.all_with_details
    render json: @ports
  end
end

