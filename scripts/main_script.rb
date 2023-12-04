# frozen_string_literal: true

require_relative '../lib/exchange_rate_updater'

exchange_rate_updater = ExchangeRateUpdater.new

# Get exchange rates of [EUR USD THB CHF ANG] with CZK as base_curency
base_currency = 'CZK'
currencies = %w[EUR USD THB CHF ANG]
exchange_rates = exchange_rate_updater.get_exchange_rates(base_currency, currencies)

puts "Exchange Rates from #{base_currency}:"
exchange_rates&.each { |to_currency, rate| puts "#{base_currency}/#{to_currency}: #{rate}" }
