require 'nokogiri'
require 'open-uri'

class Port < ApplicationRecord
  validates :taken_at, presence: true
  validates :number, presence: true
  validates :taken_at, uniqueness: {scope: :number}
  include Zortificator

  def self.pull_data
    bodyData = bwt_data

    bodyData['border_wait_time']['port'].each do |port|
      updateTime, portNumber, portStatus, data = ZortNgine.new.parsePortData(port)
      Port.create(taken_at: updateTime,
                  number: portNumber,
                  status: portStatus,
                  data: data)
    end
  end

  def self.updatePortDetails
    bodyData = bwt_data
    bodyData['border_wait_time']['port'].each do |port|
      details = {}
      details[:border_name] = port['border']
      details[:crossing_name] = port['crossing_name'] if port['crossing_name'] != nil
      details[:name] = port['port_name']
      details[:hours] = port['hours']

      case details[:hours]
      when '24 hrs/day'
        details[:opens_at] = 0
        details[:closed_at] = 24

      when '7 am-11 pm'
        details[:opens_at] = 7
        details[:closed_at] = 23

      when '8 am-Midnight'
        details[:opens_at] = 8
        details[:closed_at] = 24

      when '6 am-10 pm'
        details[:opens_at] = 6
        details[:closed_at] = 22

      when '6 am-Midnight'
        details[:opens_at] = 6
        details[:closed_at] = 24

      when '3 am-Midnight'
        details[:opens_at] = 3
        details[:closed_at] = 24

      when '10 am-6 pm'
        details[:opens_at] = 10
        details[:closed_at] = 18

      when '6 am-8 pm'
        details[:opens_at] = 6
        details[:closed_at] = 20

      when '7 am-Midnight'
        details[:opens_at] = 7
        details[:closed_at] = 24

      when '9 am-8 pm'
        details[:opens_at] = 9
        details[:closed_at] = 20

      when '5 am-11 pm'
        details[:opens_at] = 5
        details[:closed_at] = 23

      end

      PortDetail.create(
        number: port['port_number'],
        details: details)
    end
  end

  def self.all_with_details
    border_with_details = []
    PortDetail.all.each do |pd|
      border_with_details.push id: pd.id, name: pd.full_name
    end
    border_with_details
  end

  private

  def self.bwt_data
    page = Nokogiri::XML(open("https://bwt.cbp.gov/xml/bwt.xml"))
    body = Hash.from_xml(page.to_s)
    body
  end

end