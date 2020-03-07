class PullDataJob < ApplicationJob
  queue_as :data_sync

  def perform(*args)
    SyncDataService.pull_data
    BordersService.touch_recents
  end
end
