module Countries
  class List
    include Interactor

    def call
      context.countries = ISO3166::Country.all.select { |c| EshopCountries::CODES.include?(c.alpha2) }.sort_by(&:name)
    end
  end
end
