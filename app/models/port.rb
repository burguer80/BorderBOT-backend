class Port < ApplicationRecord
  validates :taken_at, presence: true
  validates :number, presence: true
  validates :taken_at, uniqueness: {scope: :number}
  include Zortificator

  def self.zortificateInBatches
    for border in Border.where("zortificated = false").limit(10)
      for port in border.data["border_wait_time"]["port"]
        updateTime, portNumber, portStatus, data = ZortNgine.new.parsePortData(port)
        Port.create(
            taken_at: updateTime,
            number: portNumber,
            status: portStatus,
            data: data)
      end
      border.zortificated = true
      border.save
    end
  end

  def self.createPortCatalog
    for port in Border.last.data["border_wait_time"]["port"]
      #Get Details values
      details = {}
      details[:border_name] = port['border']
      if port['crossing_name'] != nil then
        details[:crossing_name] = port['crossing_name']
      end
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

      PortsInfo.create(
          number: port['port_number'],
          details: details)
    end
  end

  def self.training_data(port_number)
    self.where(number: port_number).map do |p|
      [p.taken_at.to_i,
       p.status.to_s,
       p.data.dig('passenger', 'standard_lanes', 'lanes_open').to_i || 0,
       p.data.dig('passenger', 'standard_lanes', 'operational_status').to_s || 'no delay',
       p.data.dig('passenger', 'standard_lanes', 'delay_minutes').to_i || 0]
    end
  end

end