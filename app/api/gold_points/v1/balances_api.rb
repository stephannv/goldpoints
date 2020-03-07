module GoldPoints
  module V1
    class BalancesAPI < Grape::API
      desc 'List balances'
      get '/balances' do
        result = Balances::List.call(user: current_user)

        present :balances, result.balances, with: ::BalanceEntity
      end
    end
  end
end
