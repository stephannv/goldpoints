module Records
  class List
    include Interactor

    def call
      context.records = context.user.records.order(occurred_at: :desc)
    end
  end
end
