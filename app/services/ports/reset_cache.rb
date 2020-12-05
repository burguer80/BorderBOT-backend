# frozen_string_literal: true
class Ports::ResetCache

  def call
    clear_cache
    Ports::RefreshLatestWaitTimesCache.new.call
  end

  private

  def clear_cache
    Cache::Delete.new(:ports).call
  end
end