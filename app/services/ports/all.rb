# frozen_string_literal: true

class Ports::All
  def call
    fetch
  end

  private

  def fetch
    cached.presence || save_to_cache
  end

  def cached
    Cache::Read.new(:ports).call
  end

  def save_to_cache
    Cache::Write.new(:ports).call(formatted_records)
    cached
  end

  def formatted_records
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
