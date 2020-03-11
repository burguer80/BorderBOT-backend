# frozen_string_literal: true
require 'net/http'

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
      end
    end
  end

  def get_port_btw(port_number, date_param)
    url_encoded_port_number = get_url_code(port_number) + port_number
    url = "https://bwt.cbp.gov/api/bwtwaittimegraph/#{url_encoded_port_number}/#{date_param}"
    json_data = get_json(url)
    data = {commercial: json_data[0]["commercial_time_slots"]["commercial_slot"],
            private: json_data[0]["private_time_slots"]["private_slot"],
            pedestrain: json_data[0]["pedestrain_time_slots"]["pedestrain_slot"]}
    date = Date.parse(date_param)
    pwt = PortWaitTime.where(port_number: port_number, date: date.all_day).first_or_create
    pwt.port_number = port_number
    pwt.date = Date.strptime(json_data[0]["date"], "%Y-%m-%d")
    pwt.data = data
    pwt.save
  end

  private

  def get_json(url)
    uri = URI(url)
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end

  def get_url_code(port_number)
    case port_number
    when *%w(300401 300402 300403 300901 302301 331001 340101 360401)
      '02'
    when *%w(380001 380002 380201 380301)
      '03'
    when *%w(070101 070401 070801 071201 090101 090102 090103 090104)
      '04'
    when *%w(010401 010601 010901 011501 011502 011503 020901 021101 021201)
      '05'
    when *%w(240201 240202 240203 240204 240301 240401 240601 240801 l24501)
      '06'
    when *%w(230201 230301 230302 230401 230402 230403 230404 230501 230502 230503 230701 230901 230902 231001 535501 535502 535503 535504)
      '07'
    when *%w(260101 260201 260301 260401 260402 260403 260801 260802)
      '08'
    when *%w(250201 250301 250302 250401 250407 250409 250501 250601 250602)
      '09'
    end
  end

end
