# frozen_string_literal: true

%w[net/http json].each do |file|
  require file
end

%w[
  files/shared_constants
  errors/json_parsing_error
].each do |file|
  require_relative file
end

class ExchangeRateFetcher
  def initialize(base_currency)
    @base_currency = base_currency
    @rates_resources = load_rate_resources
  end

  attr_reader :base_currency, :rates_resources

  def fetch_exchange_rates
    uri = URI(String(rates_resources[base_currency]['source']))
    response = Net::HTTP.get_response(uri)

    return nil unless response.is_a?(Net::HTTPSuccess)

    begin
      parsed_response = JSON.parse(response.body)
      parsed_response if
        parsed_response.key?(rates_resources[base_currency]['data_key'])
    rescue JSON::ParserError => e
      Errors::JsonParsingError.new(code: e.message).log_error
    end
  end

  private

  def load_rate_resources
    Files::SharedConstants::RATES_RESOURCES
  end
end
