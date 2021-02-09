FactoryBot.define do
  factory :port do
    taken_at { Faker::Date.between(from: 2.days.ago, to: Date.today) }
    status { %w[Open Closed].sample }
    lanes { { "passenger" =>
                { "standard_lanes" =>
                    { "lanes_open" => rand(10), "delay_minutes" => rand(120), "operational_status" => "no delay" } },
              "commercial" => { "standard_lanes" => { "operational_status" => "Lanes Closed" } },
              "pedestrian" =>
                { "standard_lanes" =>
                    { "lanes_open" => rand(10), "delay_minutes" => rand(120), "operational_status" => "no delay" } } } }
    number { %w[070801 300401 300402 300403 090104 090101 090102 090103 011501 011503 011502 071201 020901 380001 380002 021201 010601 360401 010401 302301 010901 070401 021101 070101 340101 380201 380301 300901 331001 250201 535501 535504 535503 535502 250301 250302 240601 230201 260101 230301 230302 240201 240202 240204 240203 240401 l24501 230503 230501 230502 230401 230402 230403 230404 260201 260301 260401 260402 260403 250602 250601 250603 240301 230902 230901 230701 231001 260801 260802 250401 250407 240801 250501 250409 240805 240806 240807].sample
    }
  end
end
