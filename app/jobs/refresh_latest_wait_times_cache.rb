class RefreshLatestWaitTimesCache < ApplicationJob
  queue_as :ports

  def perform
    Ports::RefreshLatestWaitTimesCache.new.call
  end
end
