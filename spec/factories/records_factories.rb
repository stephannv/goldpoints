FactoryBot.define do
  factory :record do
    user
    group { %w[expense income].sample }
    points { Faker::Number.number(digits: 3) }
    country_code { EshopCountries::CODES.sample }
    occurred_at { Faker::Date.between(from: 90.days.ago, to: Time.zone.today) }
    description { Faker::Lorem.word }

    after :build do |record|
      record.expires_on = record.occurred_at + 1.year
      record.amount = PointsConverter.convert_to_money(points: record.points, country_code: record.country_code)
    end
  end
end
