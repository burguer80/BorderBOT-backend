# frozen_string_literal: true

class PortsService
  class << self
    def all
      ports
    end

    def reset_cache
      clear_cache
      ports
    end

    def valid(port_number)
      valid_ports_ids.include? port_number
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
          time_zone: port.time_zone,
          created_at: port.created_at,
          updated_at: port.updated_at
        }
      end
      ports_list
    end

    def valid_ports_ids
      Rails.cache.fetch(:valid_ports_ids, expires_in: EXPIRE_TIME) do
        PortDetail.all.pluck(:number)
      end
    end

  end
end
