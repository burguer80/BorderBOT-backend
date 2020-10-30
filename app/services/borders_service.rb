# TODO: remove all the implementation related with this end point

# frozen_string_literal: true
class BordersService

  def self.recents
    recent_borders
  end

  def self.touch_recents
    update_recents_cache
    recent_borders
  end


  private
  EXPIRE_TIME = 1.day

  def self.recent_borders_list
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
    borders
  end

  def self.payload
    {
      ports: recent_borders_list,
      updated_at: Time.zone.now
    }
  end

  def self.recent_borders
    JSON.parse(
      Rails.cache.fetch(:recent_borders, expires_in: EXPIRE_TIME) do
        payload.to_json
      end
    )
  end

  def self.update_recents_cache
      Rails.cache.write(:recent_borders, payload.to_json, expires_in: EXPIRE_TIME)
  end
end
