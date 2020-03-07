class CountryEntity < BaseEntity
  expose :name
  expose :alpha2, as: :code
end
