FactoryBot.define do
  factory :port do
    taken_at { Faker::Date.between(from: 2.days.ago, to: Date.today) }
    status { ['Open', 'Closed'].sample }
    data { {"passenger" =>
              {"standard_lanes" =>
                 {"lanes_open" => 2, "delay_minutes" => 5, "operational_status" => "no delay"}},
            "commercial" => {"standard_lanes" => {"operational_status" => "Lanes Closed"}},
            "pedestrian" =>
              {"standard_lanes" =>
                 {"lanes_open" => 2, "delay_minutes" => 1, "operational_status" => "no delay"}}} }
    number { "250501" }
  end
end
