class AddTimeZoneToPortDetail < ActiveRecord::Migration[6.0]
  def change
    add_column :port_details, :time_zone, :string
    add_time_zone_to_port_details unless Rails.env.test?
  end

  private

  PORTS = [
    {
      port_number: "070801",
      time_zone: "EDT"
    },
    {
      port_number: "300401",
      time_zone: "PDT"
    },
    {
      port_number: "300402",
      time_zone: "PDT"
    },
    {
      port_number: "300403",
      time_zone: "PDT"
    },
    {
      port_number: "090104",
      time_zone: "EDT"
    },
    {
      port_number: "090101",
      time_zone: "EDT"
    },
    {
      port_number: "090102",
      time_zone: "EDT"
    },
    {
      port_number: "090103",
      time_zone: "EDT"
    },
    {
      port_number: "011501",
      time_zone: "EDT"
    },
    {
      port_number: "011503",
      time_zone: "EDT"
    },
    {
      port_number: "011502",
      time_zone: "EDT"
    },
    {
      port_number: "071201",
      time_zone: "EDT"
    },
    {
      port_number: "020901",
      time_zone: "EDT"
    },
    {
      port_number: "380001",
      time_zone: "EDT"
    },
    {
      port_number: "380002",
      time_zone: "EDT"
    },
    {
      port_number: "021201",
      time_zone: "EDT"
    },
    {
      port_number: "010601",
      time_zone: "EDT"
    },
    {
      port_number: "360401",
      time_zone: "CDT"
    },
    {
      port_number: "010401",
      time_zone: "EDT"
    },
    {
      port_number: "302301",
      time_zone: "PDT"
    },
    {
      port_number: "010901",
      time_zone: "EDT"
    },
    {
      port_number: "070401",
      time_zone: "EDT"
    },
    {
      port_number: "021101",
      time_zone: "EDT"
    },
    {
      port_number: "070101",
      time_zone: "EDT"
    },
    {
      port_number: "340101",
      time_zone: "CDT"
    },
    {
      port_number: "380201",
      time_zone: "EDT"
    },
    {
      port_number: "380301",
      time_zone: "EDT"
    },
    {
      port_number: "300901",
      time_zone: "PDT"
    },
    {
      port_number: "331001",
      time_zone: "MDT"
    },
    {
      port_number: "250201",
      time_zone: "PDT"
    },
    {
      port_number: "535501",
      time_zone: "CDT"
    },
    {
      port_number: "535504",
      time_zone: "CDT"
    },
    {
      port_number: "535503",
      time_zone: "CST"
    },
    {
      port_number: "535502",
      time_zone: "CDT"
    },
    {
      port_number: "250301",
      time_zone: "PDT"
    },
    {
      port_number: "250302",
      time_zone: "PDT"
    },
    {
      port_number: "240601",
      time_zone: "MDT"
    },
    {
      port_number: "230201",
      time_zone: "CDT"
    },
    {
      port_number: "260101",
      time_zone: "PDT"
    },
    {
      port_number: "230301",
      time_zone: "CDT"
    },
    {
      port_number: "230302",
      time_zone: "CDT"
    },
    {
      port_number: "240201",
      time_zone: "MDT"
    },
    {
      port_number: "240202",
      time_zone: "MDT"
    },
    {
      port_number: "240204",
      time_zone: "MDT"
    },
    {
      port_number: "240203",
      time_zone: "MDT"
    },
    {
      port_number: "240401",
      time_zone: "MDT"
    },
    {
      port_number: "l24501",
      time_zone: "MDT"
    },
    {
      port_number: "230503",
      time_zone: "CDT"
    },
    {
      port_number: "230501",
      time_zone: "CDT"
    },
    {
      port_number: "230502",
      time_zone: "CDT"
    },
    {
      port_number: "230401",
      time_zone: "CDT"
    },
    {
      port_number: "230402",
      time_zone: "CDT"
    },
    {
      port_number: "230403",
      time_zone: "CDT"
    },
    {
      port_number: "230404",
      time_zone: "CDT"
    },
    {
      port_number: "260201",
      time_zone: "MST"
    },
    {
      port_number: "260301",
      time_zone: "PDT"
    },
    {
      port_number: "260401",
      time_zone: "MST"
    },
    {
      port_number: "260402",
      time_zone: "MST"
    },
    {
      port_number: "260403",
      time_zone: "PDT"
    },
    {
      port_number: "250602",
      time_zone: "PDT"
    },
    {
      port_number: "250601",
      time_zone: "PDT"
    },
    {
      port_number: "240301",
      time_zone: "CDT"
    },
    {
      port_number: "230902",
      time_zone: "CDT"
    },
    {
      port_number: "230901",
      time_zone: "CDT"
    },
    {
      port_number: "230701",
      time_zone: "CDT"
    },
    {
      port_number: "231001",
      time_zone: "CDT"
    },
    {
      port_number: "260801",
      time_zone: "MST"
    },
    {
      port_number: "260802",
      time_zone: "MST"
    },
    {
      port_number: "250401",
      time_zone: "PDT"
    },
    {
      port_number: "250409",
      time_zone: "PDT"
    },
    {
      port_number: "250407",
      time_zone: "PDT"
    },
    {
      port_number: "240801",
      time_zone: "MDT"
    },
    {
      port_number: "250501",
      time_zone: "PDT"
    }
  ]

  def add_time_zone_to_port_details
    PORTS.each do |p|
      port = PortDetail.find_by(number: p[:port_number])
      port.update(time_zone: p[:time_zone])
    end
  end
end
