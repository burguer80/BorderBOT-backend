# frozen_string_literal: true

class Ports::All
  include Cacheable

  def call
    ports
  end

  private

  def all_ports
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

  def ports
    Rails.cache.fetch(:ports, expires_in: 5.days) do
      all_ports
    end
  end
end
