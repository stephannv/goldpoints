module GoldPoints
  class BaseAPI < Grape::API
    cascade false

    mount V1::BaseAPI
  end
end
