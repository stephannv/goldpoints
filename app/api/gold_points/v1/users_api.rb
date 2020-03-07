module GoldPoints
  module V1
    class UsersAPI < Grape::API
      helpers do
        def user_params
          declared(params, include_missing: false)[:user].symbolize_keys
        end
      end

      desc 'Create a new user'
      route_setting :auth, public: true
      params do
        requires :user, type: Hash do
          requires :email, type: String
          requires :password, type: String
          requires :password_confirmation, same_as: :password, type: String
        end
      end

      post '/users' do
        result = Users::Create.call(user_attributes: user_params)

        present :user, result.user, with: ::UserEntity
      end
    end
  end
end
