module GoldPoints
  module V1
    class AccountStatementsAPI < Grape::API
      desc 'List records grouped by date'
      get '/account_statements' do
        result = AccountStatements::List.call(user: current_user)

        present :account_statements, result.account_statements, with: ::AccountStatementEntity
      end
    end
  end
end
