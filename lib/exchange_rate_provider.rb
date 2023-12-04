# frozen_string_literal: true

%w[
  exchange_rate_fetcher
  errors/invalid_base_currency_error
  files/shared_constants
].each do |file|
  require_relative file
end

class ExchangeRateProvider
  CACHE_TTL = 60 * 60 * 24

  attr_reader :base_currency, :rates_resources

  def initialize(base_currency)
    @base_currency = base_currency
    @fetcher = ExchangeRateFetcher.new(base_currency)
    @rates_resources = Files::SharedConstants::RATES_RESOURCES
    @last_updated_at = nil
  end

  def get_exchange_rates(currencies)
    return handle_invalid_base_currency unless valid_base_currency?

    update_exchange_rates if expired_cache?
    currencies.to_h { |currency| [currency, @exchange_rates[currency]] }
  end

  private

  def valid_base_currency?
    rates_resources.keys.include?(base_currency)
  end

  def handle_invalid_base_currency
    log_error
    nil
  end

  def log_error
    Errors::InvalidBaseCurrencyError.new(code: base_currency).log_error
  end

  def update_exchange_rates
    rates = @fetcher.fetch_exchange_rates
    return unless rates

    update_rates(rates)
    log_last_update
  end

  def update_rates(rates)
    order_key = rates_resources[base_currency]['order_key']
    data_key = rates_resources[base_currency]['data_key']
    rate_key = rates_resources[base_currency]['rate_key']

    @exchange_rates = rates[data_key].to_h { |rate| [rate[order_key], rate[rate_key]] }
  end

  def log_last_update
    @last_updated_at = Time.now
  end

  def expired_cache?
    @last_updated_at.nil? || (Time.now - @last_updated_at) > CACHE_TTL
  end
end
