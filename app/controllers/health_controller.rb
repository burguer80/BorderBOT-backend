class HealthController < ApplicationController
  def index
    render status: 418
  end
end

