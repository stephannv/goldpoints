module GoldPoints
  module V1
    class RecordsAPI < Grape::API
      helpers do
        def record_params
          declared(params, include_missing: false)[:record].symbolize_keys
        end
      end

      desc 'List records'
      get '/records' do
        result = Records::List.call(user: current_user)

        present :records, result.records, with: ::RecordEntity
      end

      desc 'Create a new record'
      params do
        requires :record, type: Hash do
          requires :group, type: String, values: %w[expense income]
          requires :points, type: Integer
          requires :country_code, type: String, values: EshopCountries::CODES
          requires :occurred_at, type: DateTime
          optional :description, type: String
        end
      end

      post '/records' do
        result = Records::Create.call(user: current_user, record_attributes: record_params)

        present :record, result.record, with: ::RecordEntity
      end

      desc 'Update a record'
      params do
        requires :id, type: String
        requires :record, type: Hash do
          optional :group, type: String, values: %w[expense income]
          optional :points, type: Integer
          optional :country_code, type: String, values: EshopCountries::CODES
          optional :occurred_at, type: DateTime
          optional :description, type: String

          at_least_one_of :group, :points, :country_code, :occurred_on, :description
        end
      end

      put '/records/:id' do
        result = Records::Update.call(user: current_user, id: params[:id], record_attributes: record_params)

        present :record, result.record, with: ::RecordEntity
      end

      desc 'Destroy a record'
      params do
        requires :id, type: String
      end

      delete '/records/:id' do
        Records::Destroy.call(user: current_user, id: params[:id])

        status :no_content
      end
    end
  end
end
