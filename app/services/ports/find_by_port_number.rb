# frozen_string_literal: true
class Ports::FindByPortNumber < Ports::Base
  def initialize(port_number)
    @port_number = port_number
  end

  def call
    return false unless @port_number.present?
    find
  end

  private

  def prexifed_key_name
    "#{PREFIX_KEY_NAME}#{@port_number}"
  end

  def stored_port
    Cache::Read.new(prexifed_key_name).call
  end

  def find
    stored_port || Ports::RefreshLatestWaitTimesCache.new.call
  end
end