class RecordEntity < BaseEntity
  expose :id
  expose :points
  expose :group
  expose :description

  expose :country do
    expose(:name) { |record| ISO3166::Country.new(record.country_code).name }
    expose :country_code, as: :code
  end

  expose :amount do
    expose(:value) { |record| record.amount.to_d.to_s }
    expose :amount_currency, as: :currency
    expose(:formatted) { |record| record.amount.formatted }
  end

  with_options format_with: :iso_timestamp do
    expose :occurred_at
    expose :expires_on
  end
end
