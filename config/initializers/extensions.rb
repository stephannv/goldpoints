Dir[Rails.root.join('lib/extensions/*.rb')].sort.each { |file| require file }

Money.include Extensions::Money
