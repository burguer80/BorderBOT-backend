# frozen_string_literal: true

class BordersController < ApplicationController
  def pull_data
    sd = SyncDataService.new
    sd.pull_data

    render status: 200
  end

  def index
    ports_total = SyncDataService.new.ports_total
    render json: ports_total
  end

  def push_data
    sd = SyncDataService.new
    sd.push_to_firebase

    render status: 200
  end
end
