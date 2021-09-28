# frozen_string_literal: true

class Ports::FindByPortNumber < Ports
  # TODO: remove this when show enpoint is removed

  def initialize(port_number)
    @port_number = port_number
  end

  def call
    find
  end

  private

  def find
    port = stored_port
    return port if port.present?

    Ports::RefreshLatestWaitTimesCache.new.call
    stored_port
  end

  def stored_port
    Cache::Read.new(prefixed_port_number(@port_number)).call
  end
end