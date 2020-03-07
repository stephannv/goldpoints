module Records
  class Create
    include Interactor

    def call
      context.record = context.user.records.new(context.record_attributes)
      fill_calculated_attributes(context.record)
      context.record.save!
    end

    def fill_calculated_attributes(record)
      record.expires_on = calculate_expiration_date(record)
      record.amount = calculate_amount(record)
    end

    def calculate_expiration_date(record)
      return if record.expense? || record.occurred_at.blank?

      record.occurred_at.to_date + 1.year
    end

    def calculate_amount(record)
      return if record.country_code.blank? || record.points.blank?

      PointsConverter.convert_to_money(points: record.points, country_code: record.country_code)
    end
  end
end
