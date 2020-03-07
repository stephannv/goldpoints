module GoldPoints
  module V1
    class AuthenticationsAPI < Grape::API
      desc 'Authenticate user'
      route_setting :auth, public: true
      params do
        requires :credentials, type: Hash do
          requires :email, type: String
          requires :password, type: String
        end
      end

      post '/authentications' do
        result = Users::AuthenticateByCredentials.call(credentials: declared(params)[:credentials])

        if result.success?
          present :token, result.token
        else
          error!({ message: 'Unauthorized' }, 401)
        end
      end
    end
  end
end
