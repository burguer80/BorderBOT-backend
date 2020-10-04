# frozen_string_literal: true

class PortsService

  def all
    ports
  end

  def reset_cache
    clear_cache
    ports
  end

  private

  EXPIRE_TIME = 1.day

  def clear_cache
    Rails.cache.delete(:ports)
  end

  def ports
    JSON.parse(
      Rails.cache.fetch(:ports, expires_in: EXPIRE_TIME) do
        front_end_format.to_json
      end
    )
  end

  def front_end_format
    ports_list = []
    PortDetail.all.each do |port|
      ports_list << {
        id: port.number,
        details: port.details,
        created_at: port.created_at,
        updated_at: port.updated_at
      }
    end
    ports_list
  end
end
