FactoryBot.define do
  factory :port_detail do
    number { random_port_number }
    details { { name: random_port_name,
                hours: "10 am-6 pm",
                opens_at: 10,
                closed_at: 18,
                border_name: random_border_name,
                crossing_name: random_crossing_name } }
    time_zone { random_time_zones }
    created_at { 1.year.ago }
    updated_at { created_at }
  end
end

def random_port_number
  port_numbers = %w[010401 010601 010901 011501 011502 011503 020901 021101 021201 070101 070401 070801 071201 090101 090102 090103 090104 230201 230301 230302 230401 230402 230403 230404 230501 230502 230503 230701 230901 230902 231001 240201 240202 240203 240204 240301 240401 240601 240801 250201 250301 250302 250401 250407 250409 250501 250601 250602 260101 260201 260301 260401 260402 260403 260801 260802 300401 300402 300403 300901 302301 331001 340101 360401 380001 380002 380201 380301 535501 535502 535503 535504 l24501]
  port_numbers.sample
end

def random_port_name
  port_names = ["Douglas (Raul Hector Castro)", "Naco", "Alexandria Bay", "Blaine", "Blaine", "Blaine", "Buffalo/Niagara Falls", "Buffalo/Niagara Falls", "Buffalo/Niagara Falls", "Buffalo/Niagara Falls", "Calais", "Calais", "Calais", "Champlain", "Derby Line", "Detroit", "Detroit", "Highgate Springs", "Houlton", "International Falls", "Jackman", "Lynden", "Madawaska", "Massena", "Norton", "Ogdensburg", "Pembina", "Port Huron", "Sault Ste. Marie", "Sumas", "Sweetgrass", "Brownsville", "Brownsville", "Brownsville", "Brownsville", "Andrade", "Calexico", "Calexico", "Columbus", "Del Rio", "Eagle Pass", "Eagle Pass", "El Paso", "El Paso", "El Paso", "El Paso", "Fabens", "Fort Hancock", "Hidalgo/Pharr", "Hidalgo/Pharr", "Hidalgo/Pharr", "Laredo", "Laredo", "Laredo", "Laredo", "Lukeville", "Nogales", "Nogales", "Nogales", "Otay Mesa", "Otay Mesa", "Presidio", "Progreso", "Progreso", "Rio Grande City", "Roma", "San Luis", "San Luis", "San Ysidro", "San Ysidro", "San Ysidro", "Santa Teresa", "Tecate"]
  port_names.sample
end

def random_border_name
  border_names = ["Mexican Border", "Canadian Border"]
  border_names.sample
end

def random_crossing_name
  crossing_names = ["Thousand Islands Bridge", "Pacific Highway", "Peace Arch", "Point Roberts", "Lewiston Bridge", "Peace Bridge", "Rainbow Bridge", "Whirlpool Bridge", "Ferry Point", "International Avenue", "Milltown", "Ambassador Bridge", "Windsor Tunnel", "Bluewater Bridge", "International Bridge   SSM", "B&M", "Gateway", "Los Indios", "Veterans International", "East", "West", "Bridge I", "Bridge II", "Bridge of the Americas (BOTA)", "Paso Del Norte (PDN)", "Stanton DCL", "Ysleta", "Tornillo", "Fort Hancock", "Anzalduas International Bridge", "Hidalgo", "Pharr", "Colombia Solidarity", "World Trade Bridge", "Deconcini", "Mariposa", "Morley Gate", "Commercial", "Passenger", "Donna International Bridge", "Progreso International Bridge", "San Luis I", "San Luis II", "Cross Border Express", "PedWest", "Santa Teresa Port of Entry"]
  crossing_names.sample
end

def random_time_zones
  time_zoness = ["PDT", "EDT", "CDT", "MDT", "CST", "MST"]
  time_zoness.sample
end
