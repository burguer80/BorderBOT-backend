# frozen_string_literal: true

class Ports::All
  def call
    ports
  end

  private

  def stored_ports
    Cache::Read.new(:ports).call
  end

  def save_ports
    Cache::Write.new(:ports).call(formatted_ports)
    stored_ports
  end

  def ports
    stored_ports || save_ports
  end

  def formatted_ports
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
