class PushDataJob < ApplicationJob
  queue_as :data_sync

  def perform(*args)
    sd = SyncDataService.new
    sd.push_to_firebase
  end
end
