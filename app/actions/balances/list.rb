module Balances
  class List
    include Interactor

    def call
      context.balances = context.user.balances.order(points: :desc)
    end
  end
end
