class PushDataJob < ApplicationJob
  queue_as :data_sync

  def perform(*args)
    SyncDataService.push_to_firebase
  end
end
