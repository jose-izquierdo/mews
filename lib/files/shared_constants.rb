# frozen_string_literal: true

module Files
  module SharedConstants
    RATES_RESOURCES = JSON.parse(File.read('lib/files/exchange_rates_resources_by_currency.json'))
  end
end
