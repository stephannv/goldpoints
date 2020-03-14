class AccountStatementEntity < BaseEntity
  with_options format_with: :iso_timestamp do
    expose :occurrence_date
  end

  expose :records, using: RecordEntity
end
