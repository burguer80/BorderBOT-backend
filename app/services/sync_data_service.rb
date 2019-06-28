# frozen_string_literal: true

class SyncDataService

  PORTS_DETAILS_FILE = 'public/ports.json'

  def ports_total
    get_ports_json_file
  end

  def pull_data
    Port.pull_data
    Port.updatePortDetails
    create_ports_json_file
  end

  def push_to_firebase
    firebase_url = ENV['firebase_url']
    firebase_secret = ENV['firebase_secret']
    return nil unless firebase_url && firebase_secret
    borders = []
    PortDetail.find_each do |pd|
      p = Port.where(number: pd.number).last
      borders.push id: pd.id,
                   number: pd.number,
                   name: pd.details["name"],
                   hours: pd.details["hours"],
                   opens_at: pd.details["opens_at"],
                   closed_at: pd.details["closed_at"],
                   border_name: pd.details["border_name"],
                   crossing_name: pd.details["crossing_name"],
                   status: p.status,
                   taken_at: p.taken_at,
                   data: p.data
    end

    firebase = Firebase::Client.new(firebase_url, firebase_secret)
    firebase.set("borders", borders)
    firebase.set("borders_pushed_at", pushed_at: Time.zone.now)
  end

  private

  def create_ports_json_file
    ports_detail = {ports_total: Port.count, updated_at: DateTime.now}
    File.open(PORTS_DETAILS_FILE,"w") do |f|
      f.write(ports_detail.to_json)
    end
  end

  def get_ports_json_file
    if File.exist?(PORTS_DETAILS_FILE)
      File.read(PORTS_DETAILS_FILE)
    else
      create_ports_json_file
      File.read(PORTS_DETAILS_FILE)
    end
  end
end
