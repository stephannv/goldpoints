# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Rails.env.development?
  user = User.create!(email: 'test@test.com', password: 'test123')

  [
    { occurred_at: '2020/01/01'.to_datetime, country_code: 'US', points: 300, group: :income, description: 'DQ XI' },
    { occurred_at: '2020/01/03'.to_datetime, country_code: 'US', points: 100, group: :income, description: 'NSMBU' },
    { occurred_at: '2020/01/03'.to_datetime, country_code: 'MX', points: 300, group: :income, description: 'MK8D' },
    { occurred_at: '2020/02/05 12'.to_datetime, country_code: 'US', points: 400, group: :expense, description: 'DOOM' },
    { occurred_at: '2020/02/05 13'.to_datetime, country_code: 'US', points: 250, group: :income, description: 'DOOM' },
    { occurred_at: '2020/02/07'.to_datetime, country_code: 'US', points: 50, group: :income, description: 'HK' },
    { occurred_at: '2020/02/07'.to_datetime, country_code: 'US', points: 23, group: :income, description: 'NEOGEO' },
    { occurred_at: '2020/02/10'.to_datetime, country_code: 'MX', points: 300, group: :expense, description: 'LM3' },
    { occurred_at: '2020/03/01'.to_datetime, country_code: 'JP', points: 300, group: :income, description: 'FIFA' }
  ].each do |record_attributes|
    Records::Create.call(user: user, record_attributes: record_attributes)
  end

  user2 = User.create!(email: 'test2@test.com', password: 'test123')

  [
    { occurred_at: '2020/01/01'.to_datetime, country_code: 'US', points: 300, group: :income, description: 'DQ XI' },
    { occurred_at: '2020/03/01'.to_datetime, country_code: 'FR', points: 100, group: :income, description: 'FIFA' }
  ].each do |record_attributes|
    Records::Create.call(user: user2, record_attributes: record_attributes)
  end
end
