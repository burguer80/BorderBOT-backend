# frozen_string_literal: true
class Ports::FindByPortNumber < Ports

  def initialize(port_number)
    @port_number = port_number
  end

  def call
    return false unless @port_number.present?
    find
  end

  private

  def stored_port
    Cache::Read.new(prefixed_port_number(@port_number)).call
  end

  def find
    stored_port || Ports::RefreshLatestWaitTimesCache.new.call
  end
end