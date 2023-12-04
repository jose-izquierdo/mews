# frozen_string_literal: true

require_relative 'exchange_rate_provider'

class ExchangeRateUpdater
  attr_reader :providers

  def initialize
    @providers = {}
  end

  def get_provider(base_currency)
    providers[base_currency] ||= ExchangeRateProvider.new(base_currency)
  end

  def get_exchange_rates(base_currency, currencies)
    provider = get_provider(base_currency)
    provider.get_exchange_rates(currencies)
  end
end
