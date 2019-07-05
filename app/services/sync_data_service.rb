# frozen_string_literal: true

class SyncDataService
  def ports_total
    port_details
  end

  def pull_data
    Port.pull_data
    Port.updatePortDetails
    expire_ports_details_cache
  end

  def push_to_firebase
    firebase_url = ENV['firebase_url']
    firebase_secret = ENV['firebase_secret']
    return nil unless firebase_url && firebase_secret
    borders = []
    PortDetail.find_each do |pd|
      p = Port.where(number: pd.number).last
      next unless p
      borders.push id: pd.id,
                   number: pd.number,
                   name: pd.details['name'],
                   hours: pd.details['hours'],
                   opens_at: pd.details['opens_at'],
                   closed_at: pd.details['closed_at'],
                   border_name: pd.details['border_name'],
                   crossing_name: pd.details['crossing_name'],
                   status: p.status,
                   taken_at: p.taken_at,
                   data: p.data
    end

    firebase = Firebase::Client.new(firebase_url, firebase_secret)
    firebase.set('borders', borders)
    firebase.set('borders_pushed_at', pushed_at: Time.zone.now)
  end

  private

  def expire_ports_details_cache
    Rails.cache.delete(:port_details) if Rails.cache.read(:port_details)
  end

  def port_details
    JSON.parse(
        Rails.cache.fetch(:port_details, expires_in: 10.minutes) do
          {ports_count: Port.count,
           updated_at: Time.zone.now}.to_json
        end
    )
  end
end
