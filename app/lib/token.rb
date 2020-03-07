class Token
  def self.encode(payload:, expiration_time_in_minutes:)
    payload['exp'] = expiration_time_in_minutes.minutes.from_now.to_i
    JWT.encode(payload, Rails.application.secrets.secret_key_base, 'HS256')
  end

  def self.decode(token:)
    decoded = JWT.decode(token, Rails.application.secrets.secret_key_base)
    HashWithIndifferentAccess.new(decoded[0])
  end
end
