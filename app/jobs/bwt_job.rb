class BwtJob < ApplicationJob
  queue_as :data_sync

  def perform(port_number, date= today)
    btw = BtwApiService.new
    btw.get_port_btw(port_number, date)
  end

  def today
    Date.today.strftime("%Y-%m-%d")
  end
end
