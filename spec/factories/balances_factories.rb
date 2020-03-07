FactoryBot.define do
  factory :balance do
    user
    points { Faker::Number.number(digits: 3) }
    country_code { EshopCountries::CODES.sample }

    after :build do |balance|
      balance.amount = PointsConverter.convert_to_money(points: balance.points, country_code: balance.country_code)
    end
  end
end
