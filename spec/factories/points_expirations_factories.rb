FactoryBot.define do
  factory :points_expiration do
    user
    points { Faker::Number.number(digits: 3) }
    country_code { EshopCountries::CODES.sample }
    expires_on { Faker::Date.between(from: Time.zone.today, to: 1.year.from_now) }

    after :build do |balance|
      balance.amount = PointsConverter.convert_to_money(points: balance.points, country_code: balance.country_code)
    end
  end
end
