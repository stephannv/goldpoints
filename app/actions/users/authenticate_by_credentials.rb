module Users
  class AuthenticateByCredentials
    include Interactor

    def call
      user = User.find_by(email: context.credentials[:email]).try(:authenticate, context.credentials[:password])

      context.fail! if user.blank?

      context.token = Token.encode(payload: { user_id: user.id }, expiration_time_in_minutes: 525_600) # 365.days
    end
  end
end
