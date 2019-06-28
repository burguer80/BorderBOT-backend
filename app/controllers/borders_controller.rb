# frozen_string_literal: true

class BordersController < ApplicationController
  def index
    ports_total = SyncDataService.new.ports_total
    render json: ports_total
  end
end
