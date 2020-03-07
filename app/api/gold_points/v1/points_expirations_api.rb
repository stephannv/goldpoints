module GoldPoints
  module V1
    class PointsExpirationsAPI < Grape::API
      desc 'List points expirations'
      get '/points_expirations' do
        result = PointsExpirations::List.call(user: current_user)

        present :points_expirations, result.points_expirations, with: ::PointsExpirationEntity
      end
    end
  end
end
