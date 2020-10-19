class LatestPortWaitTimesJob < ApplicationJob
  queue_as :data_sync

  def perform
    LatestPortWaitTimesService.call
    nil
  end
end
