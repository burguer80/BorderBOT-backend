# frozen_string_literal: true

class PortWaitTimesService
  LATEST_PWT_JSON_URL = ENV['LATEST_PWT_JSON_URL']


  def self.extract_ports
    bwt_list = []
    get_latest_bwt_json.map do |bwt|
      bwt_list << {
        name: "#{bwt['port_name']}, #{bwt['crossing_name']}, ",
        port_number: bwt['port_number'],
        time_zone: port_time_zone(bwt)&.last(3)
        # pulled_at:  "#{bwt['date']} #{bwt['time']} EDT",
      }
    end
    bwt_list
  end

  def self.update_time_from_vehicle_lanes(vehicle_lanes)
    update_time_with_time_zone(vehicle_lanes&.dig('FAST_lanes','update_time')) ||
      update_time_with_time_zone(vehicle_lanes&.dig('NEXUS_SENTRI_lanes','update_time')) ||
      update_time_with_time_zone(vehicle_lanes&.dig('standard_lanes','update_time')) ||
      update_time_with_time_zone(vehicle_lanes&.dig('ready_lanes','update_time'))
  end

  def self.update_time_with_time_zone(updated_time)
    updated_time&.present? ? updated_time : nil
  end

  def self.get_latest_bwt_json
    http = HttpService.new(LATEST_PWT_JSON_URL)
    http.get_json
  end

  private

  def self.port_time_zone(bwt)
    update_time_from_vehicle_lanes(bwt['commercial_vehicle_lanes']) || update_time_from_vehicle_lanes(bwt['passenger_vehicle_lanes']) || update_time_from_vehicle_lanes(bwt['pedestrian_lanes'])
  end
end
