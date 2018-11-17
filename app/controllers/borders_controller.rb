# frozen_string_literal: true

class BordersController < ApplicationController
  def pull_data
    Port.pull_data
    Port.updatePortDetails
    Rails.cache.write('total_ports', Port.count)

    render status: 200
  end

  def index
    ports_total = Rails.cache.fetch('total_ports') { Port.count }
    render json: { ports: ports_total }
  end

end
