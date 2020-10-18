# frozen_string_literal: true

class LatestPortWaitTimesService

  def self.call
    extract_ports
  end

  private

  LATEST_PWT_JSON_URL = ENV['LATEST_PWT_JSON_URL']

  def self.extract_ports
    bwt_list = []
    get_latest_bwt_json.map do |bwt|
      bwt_list << bwt_formatted(bwt)
    end
    bwt_list
  end

  def self.bwt_formatted(bwt)
    port_detail = PortDetail.find_by(number: bwt['port_number'])
    {
      id: bwt['port_number'],
      lanes: {
        commercial: bwt['commercial_vehicle_lanes'],
        pedestrian: bwt['pedestrian_lanes'],
        private: bwt['passenger_vehicle_lanes']
      },
      details: port_detail.details,
      hours: bwt['hours'],
      pulled_at: "#{bwt['date']} #{bwt['time']} #{port_detail.time_zone}"
    }
  end

  def self.get_latest_bwt_json
    http = HttpService.new(LATEST_PWT_JSON_URL)
    http.get_json
  end
end
