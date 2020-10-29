# frozen_string_literal: true

class LatestPortWaitTimesService
  class << self
    def call
      latest_pwt = extract_ports
      save_to_cache(latest_pwt)
      latest_pwt
    end

    def find(number)
      pwt = read_from_cache(number)
      if pwt
        pwt
      else
        call; nil
        read_from_cache(number)
      end
    end

    private

    LATEST_PWT_JSON_URL = ENV['LATEST_PWT_JSON_URL']
    PREFIX_KEY_NAME = 'latest_pwt_'

    def active_lanes(lanes)
      active_lanes = {}
      active_lanes.merge!({fast: lanes['NEXUS_SENTRI_lanes']}) if lanes['NEXUS_SENTRI_lanes'].present?
      active_lanes.merge!({standard: lanes['standard_lanes']}) if lanes['standard_lanes'].present?
      active_lanes.merge!({ready: lanes['ready_lanes']}) if lanes['ready_lanes'].present?
      active_lanes
    end

    def cache_key_name(number)
      "#{PREFIX_KEY_NAME}#{number}"
    end

    def extract_ports
      pwt_list = []
      get_latest_pwt_json.map do |pwt|
        pwt_list << pwt_formatted(pwt)
      end
      pwt_list
    end

    def get_latest_pwt_json
      http = HttpService.new(LATEST_PWT_JSON_URL)
      http.get_json
    end

    def pwt_formatted(pwt)
      port_detail = PortDetail.find_by(number: pwt['port_number'])
      {
        id: pwt['port_number'],
        lanes: {
          commercial: active_lanes(pwt['commercial_vehicle_lanes']),
          pedestrian: active_lanes(pwt['pedestrian_lanes']),
          private: active_lanes(pwt['passenger_vehicle_lanes'])
        },
        details: port_detail.details,
        hours: pwt['hours'],
        last_update_time: port_time_zone(pwt).present? ? "#{pwt['date']} #{port_time_zone(pwt)}" : '',
        port_time: "#{pwt['date']} #{pwt['time']}  #{port_detail.time_zone}"
      }
    end

    def save_to_cache(latest_pwt)
      latest_pwt.each do |pwt|
        return nil unless pwt
        CacheService.write(cache_key_name(pwt[:id]), pwt)
      end
    end

    def read_from_cache(number)
      CacheService.read(cache_key_name(number))
    end

    # TODO: these methods will help to convert the update_time based on the time zone
    # TODO: these methods could help to identify which port is open or not.
    def port_time_zone(pwt)
      port_time = update_time_from_vehicle_lanes(pwt['commercial_vehicle_lanes']) || update_time_from_vehicle_lanes(pwt['passenger_vehicle_lanes']) || update_time_from_vehicle_lanes(pwt['pedestrian_lanes'])
      replace_time_strings(port_time)
    end

    def update_time_from_vehicle_lanes(vehicle_lanes)
      update_time_with_time_zone(vehicle_lanes&.dig('NEXUS_SENTRI_lanes', 'update_time')) ||
        update_time_with_time_zone(vehicle_lanes&.dig('standard_lanes', 'update_time')) ||
        update_time_with_time_zone(vehicle_lanes&.dig('ready_lanes', 'update_time'))
    end

    def update_time_with_time_zone(updated_time)
      updated_time&.present? ? updated_time[3..-1] : nil
    end

    def replace_time_strings(port_time)
      if port_time.present? && (port_time.include? 'Noon')
        port_time.sub! 'Noon', '12:00 pm'
      else
        port_time
      end
    end
  end
end
