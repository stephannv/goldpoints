module Extensions
  module Money
    def formatted
      format(symbol: currency.to_s + ' ').strip
    end
  end
end
