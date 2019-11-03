# frozen_string_literal: true

class BtwApiService
  include ERB::Util
  HOLIDAYS = [
    "New Years Day",
    "Martin Luther King Jr. Day",
    "Presidents Day",
    "Memorial Day",
    "Independence Day",
    "Labor Day",
    "Columbus Day",
    "Veterans Day",
    "Thanksgiving Day",
    "Christmas Day"
  ]

  def get_latest_historical_btw(month_number, port_number)
    url = "https://bwt.cbp.gov/api/historicalwaittimes/09#{port_number}/POV/GEN/#{month_number}/7"
    json_data = get_json(url)
    json_data["wait_times"].each do |wt|
      record = HistoricalWaitTime.new(wt)
      record.month_number = month_number
      record.port_number = port_number
      record.save
    end
  end

  def get_latest_holidays_btw(port_number)
    total = 0
    HOLIDAYS.each do |h|
      holiday_encoded = url_encode(h)
      url = "https://bwt.cbp.gov/api/holidaywaittimes/#{port_number}/POV/GEN/#{holiday_encoded}"
      json_data = get_json(url)
      json_data["wait_times"].each do |ht|
        record = HolidayWaitTime.new(ht)
        record.port_number = port_number
        record.bwt_date = Date.strptime(ht["bwt_date"], "%m/%d/%Y")
        record.holiday_date = Time.strptime(ht["holiday_date"], "%m/%d/%Y %I:%M:%S %p")
        record.save
        # byebug
      end
      p h
      p json_data["wait_times"].size
      total += json_data["wait_times"].size
    end
    p total
  end

  private

  def get_json(url)
    uri = URI(url)
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end
end
