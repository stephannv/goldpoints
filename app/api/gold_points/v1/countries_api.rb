module GoldPoints
  module V1
    class CountriesAPI < Grape::API
      desc 'List eshop countries'
      get '/countries' do
        result = Countries::List.call

        present :countries, result.countries, with: ::CountryEntity
      end
    end
  end
end
