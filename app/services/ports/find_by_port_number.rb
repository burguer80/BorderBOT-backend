# frozen_string_literal: true
class Ports::FindByPortNumber < Ports

  def initialize(port_number)
    @port_number = port_number
  end

  def call
    find
  end

  private

  def find
    stored_port || Ports::RefreshLatestWaitTimesCache.new.call
  end

  def stored_port
    Cache::Read.new(prefixed_port_number(@port_number)).call
  end
end