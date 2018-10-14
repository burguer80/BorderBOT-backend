require 'nokogiri'
require 'open-uri'

class Border < ApplicationRecord
  validates :taken, presence: true

  def self.pull_data
    page = Nokogiri::XML(open("https://apps.cbp.gov/bwt/bwt.xml"))
    body = Hash.from_xml(page.to_s)
    borderInserted = false

    d = body['border_wait_time']['last_updated_date']
    t = body['border_wait_time']['last_updated_time']
    taken = (d + ' ' + t).to_datetime
    if Border.find_by_taken(taken) == nil
      #puts 'no existe hay que insertar el registro'
      border = Border.new
      border.taken = taken
      border.data = body
      border.save
      borderInserted = true
      #solo hay que guardar el body.borders
      #body['border_wait_time']['port'] validando que no existe
    end

    hash = {
        count: Border.count,
        created_at: Time.now}

    file = File.open('public/check_json.json', "w+")
    file.write(hash.to_json)
    file.close

    return borderInserted

  end

  def self.last_updated_timestamp
    last_border = Border.last
    t = last_border.data['border_wait_time']['last_updated_time']
    d = last_border.data['border_wait_time']['last_updated_date']
    converted_date = (d + ' ' + t).to_datetime
    return converted_date
  end
end
