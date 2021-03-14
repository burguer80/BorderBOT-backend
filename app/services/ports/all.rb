# frozen_string_literal: true

class Ports::All
  include Cacheable

  def call
    Rails.cache.fetch(:ports, expires_in: 5.days) do
      ports_with_details
    end
  end

  private

  def ports_with_details
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
