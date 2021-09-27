# frozen_string_literal: true

class Ports::RefreshLatestWaitTimesCache < Ports
  include Cacheable

  # TODO: remove save_to_cache related logic when the show end-point is removed

  def call
    save_to_cache(latest_pwt)
    # refresh_cache
  end

  private

  LATEST_PWT_JSON_URL = ENV['LATEST_PWT_JSON_URL']

  def active_lanes(lanes)
    active_lanes_list = {}
    active_lanes_list.merge!({ fast: lanes['NEXUS_SENTRI_lanes'] }) if lanes['NEXUS_SENTRI_lanes'].present?
    active_lanes_list.merge!({ standard: lanes['standard_lanes'] }) if lanes['standard_lanes'].present?
    active_lanes_list.merge!({ ready: lanes['ready_lanes'] }) if lanes['ready_lanes'].present?
    active_lanes_list
  end

  def collection_name
    :latest_wait_times
  end

  def records
    get_latest_pwt_json.map do |pwt|
      pwt_formatted(pwt)
    end
  end

  def refresh_cache
    fetch
  end

  def get_latest_pwt_json
    Http::Get.new(LATEST_PWT_JSON_URL).call
  end

  def latest_pwt
    get_latest_pwt_json.map do |pwt|
      pwt_formatted(pwt)
    end
  end

  def port_time_zone(pwt)
    port_time = update_time_from_vehicle_lanes(pwt['commercial_vehicle_lanes']) || update_time_from_vehicle_lanes(pwt['passenger_vehicle_lanes']) || update_time_from_vehicle_lanes(pwt['pedestrian_lanes'])
    replace_time_strings(port_time)
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
      details: port_detail&.details,
      hours: pwt['hours'],
      last_update_time: port_time_zone(pwt).present? ? "#{pwt['date']} #{port_time_zone(pwt)}" : '',
      port_time: "#{pwt['date']} #{pwt['time']}  #{port_detail&.time_zone}"
    }
  end

  def replace_time_strings(port_time)
    if port_time.present? && (port_time.include? 'Noon')
      port_time.sub! 'Noon', '12:00 pm'
    else
      port_time
    end
  end

  def save_to_cache(latest_pwt)
    latest_pwt.each do |pwt|
      return nil unless pwt
      prefixed_port_number = prefixed_port_number(pwt[:id])
      Cache::Write.new(prefixed_port_number).call(pwt)
    end
    Cache::Write.new(:latest_wait_times).call(latest_pwt)
    nil
  end

  def update_time_from_vehicle_lanes(vehicle_lanes)
    update_time_with_time_zone(vehicle_lanes&.dig('NEXUS_SENTRI_lanes', 'update_time')) ||
      update_time_with_time_zone(vehicle_lanes&.dig('standard_lanes', 'update_time')) ||
      update_time_with_time_zone(vehicle_lanes&.dig('ready_lanes', 'update_time'))
  end

  def update_time_with_time_zone(updated_time)
    updated_time&.present? ? updated_time[3..-1] : nil
  end
end