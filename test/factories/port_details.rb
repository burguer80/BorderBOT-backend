FactoryBot.define do
  factory :port_detail do
    number { '260403' }
    details { { name: "Nogales",
                hours: "10 am-6 pm",
                opens_at: 10,
                closed_at: 18,
                border_name: "Mexican Border",
                crossing_name: "Morley Gate" } }
  end
end
