class PullDataJob < ApplicationJob
  queue_as :data_sync

  def perform(*args)
    sd = SyncDataService.new
    sd.pull_data
  end
end
