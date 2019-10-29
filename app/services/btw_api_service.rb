# frozen_string_literal: true

class BtwApiService
  def get_latest_historical_btw(month_number, port_number)
    url = "https://bwt.cbp.gov/api/historicalwaittimes/09#{port_number}/POV/GEN/#{month_number}/7"
    json_data = get_json(url)
    json_data["wait_times"].each do | wt|
       record = HistoricalWaitTime.new(wt)
       record.month_number = month_number
       record.port_number = port_number
      record.save
    end
  end

  private

  def get_json(url)
    uri = URI(url)
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end
end
