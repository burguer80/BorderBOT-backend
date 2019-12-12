FactoryBot.define do
  factory :port do
    taken_at { Faker::Date.between(from: 2.days.ago, to: Date.today) }
    status { "Open" }
    data { "" }
    number { "250501" }
  end
end
