# frozen_string_literal: true

class Ports::All
  include Cacheable

  def call
    fetch
  end

  private

  def collection_name
    :ports
  end

  def records
    PortDetail.all.map do |port|
      {
        id: port.number,
        details: port.details,
        time_zone: port.time_zone,
        created_at: port.created_at,
        updated_at: port.updated_at
      }
    end
  end
end
