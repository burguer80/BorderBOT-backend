# frozen_string_literal: true

class Ports::NumberValid

  def call(port_number)
    return false unless port_number.present?
    valid? port_number
  end

  private

  def port_numbers
    stored_port_numbers || save_port_numbers_to_cache
  end

  def stored_port_numbers
    Cache::Read.new(:valid_ports_ids).call
  end

  def save_port_numbers_to_cache
    all_port_numbers = PortDetail.all.pluck(:number)
    Cache::Write.new(:valid_ports_ids).call(all_port_numbers)
    stored_port_numbers
  end

  def valid?(port_number)
    port_numbers&.include? port_number
  end
end