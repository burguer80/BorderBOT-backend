# TODO: remove all the implementation related with this end point
class BwtJob < ApplicationJob
  queue_as :data_sync

  def perform(port_number, date= today)
    btw = BtwApiService.new
    pwt = btw.get_port_btw(port_number, date)
    btw.cache_port(pwt) if pwt
  end

  def today
    Date.today.strftime("%Y-%m-%d")
  end
end
