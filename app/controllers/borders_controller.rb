# frozen_string_literal: true

class BordersController < ApplicationController
  def pull_data
    Port.pull_data
    Port.updatePortDetails
    Rails.cache.write('total_ports', Port.count)

    render status: 200
  end

  def index
    ports_total = Rails.cache.fetch('total_ports') {Port.count}
    render json: {ports: ports_total}
  end

  def list
    borders = []
    PortDetail.find_each do |pd|
      p = Port.where(number: pd.number).last
      borders.push id: pd.id,
                   number: pd.number,
                   name: pd.details["name"],
                   hours: pd.details["hours"],
                   opens_at: pd.details["opens_at"],
                   closed_at: pd.details["closed_at"],
                   border_name: pd.details["border_name"],
                   crossing_name: pd.details["crossing_name"],
                   status: p.status,
                   taken_at: p.taken_at,
                   data: p.data
    end

    render json: borders
  end

end
