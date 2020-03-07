module Users
  class AuthenticateByToken
    include Interactor

    def call
      token = context.authorization_header.to_s.split(' ').last
      payload = Token.decode(token: token)
      user_id = payload.try(:dig, :user_id)

      context.user = User.find_by(id: user_id)
    end
  end
end
