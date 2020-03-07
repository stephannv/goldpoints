class PointsConverter
  RATES = {
    'AUD' => 1,
    'CAD' => 1,
    'CHF' => 1,
    'CZK' => 20,
    'DKK' => 0.1,
    'EUR' => 1,
    'GBP' => 1,
    'JPY' => 1,
    'MXN' => 20,
    'NOK' => 0.1,
    'NZD' => 1,
    'PLN' => 5,
    'RUB' => 1,
    'SEK' => 0.1,
    'USD' => 1,
    'ZAR' => 10
  }.freeze

  def self.convert_to_money(points:, country_code:)
    currency = eshop_currency_by_country_code(country_code)
    rate = RATES[currency]
    Money.new(points * rate, currency)
  end

  def self.eshop_currency_by_country_code(country_code)
    case country_code
    when 'HU', 'HR', 'IL', 'RO', 'BG'
      'EUR'
    else
      ISO3166::Country.new(country_code).currency_code
    end
  end
end
