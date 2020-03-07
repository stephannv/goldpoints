module Records
  class Destroy
    include Interactor

    def call
      context.record = context.user.records.find(context.id)
      context.record.destroy!
    end
  end
end
