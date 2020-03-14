module AccountStatements
  class List
    include Interactor

    def call
      context.account_statements = context.user.records
        .order(occurred_at: :desc)
        .group_by { |record| record.occurred_at.to_date }
        .map { |occurrence_date, records| { occurrence_date: occurrence_date, records: records } }
    end
  end
end
