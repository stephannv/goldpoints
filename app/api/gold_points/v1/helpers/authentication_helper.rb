module GoldPoints
  module V1
    module Helpers
      module AuthenticationHelper
        def authenticate_request!
          error!({ message: 'Unauthorized' }, 401) if current_user.nil?
        end

        def public_route?
          route.settings.try(:dig, :auth, :public)
        end

        def current_user
          return if headers['Authorization'].blank?

          result = Users::AuthenticateByToken.call(authorization_header: headers['Authorization'])

          @current_user ||= result.user
        end
      end
    end
  end
end
