module GoldPoints
  module V1
    class BaseAPI < Grape::API
      version :v1, using: :path
      format :json

      rescue_from ActiveRecord::RecordInvalid do |e|
        error!({ errors: e.record.errors.messages }, 422)
      end

      rescue_from ActiveRecord::RecordNotDestroyed do |e|
        error!({ errors: e.record.errors.messages }, 409)
      end

      rescue_from Grape::Exceptions::ValidationErrors do |e|
        error!({ errors: e.full_messages }, 400)
      end

      rescue_from ActiveRecord::RecordNotFound do |e|
        error!({ error: e.message }, 404)
      end

      rescue_from :all do |e|
        raise e if Rails.env.development?

        error!({ error: 'Internal server error' }, 500)
      end
    end
  end
end
