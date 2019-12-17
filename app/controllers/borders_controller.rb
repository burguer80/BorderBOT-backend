# frozen_string_literal: true

class BordersController < ApplicationController
  def index
    ports_total = SyncDataService.ports_total
    render json: ports_total
  end
end
