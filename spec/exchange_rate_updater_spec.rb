# frozen_string_literal: true

RSpec.describe ExchangeRateUpdater do
  let(:exchange_rate_updater) { ExchangeRateUpdater.new }
  describe '#get_provider' do
    it 'returns a ExchangeRateUpdater instance' do
      provider = exchange_rate_updater.get_provider('CZK')
      expect(provider).to be_an_instance_of(ExchangeRateProvider)
    end

    it 'returns the same provider for the same base currency' do
      converter1 = exchange_rate_updater.get_provider('CZK')
      converter2 = exchange_rate_updater.get_provider('CZK')
      expect(converter1).to be(converter2)
    end
  end

  describe '#get_exchange_rates' do
    let(:expected_response) { { 'EUR' => 24.39, 'USD' => 22.442 } }
    it 'returns exchange rates for specified currencies' do
      VCR.use_cassette('exchange_rates_updater') do
        currencies = %w[EUR USD]

        response = exchange_rate_updater.get_exchange_rates('CZK', currencies)

        response.each do |code, rate|
          expect(currencies.include?(code)).to be true
          expect(rate.class).to eq Float
        end

        expect(expected_response).to match response
      end
    end

    it 'returns only found exchange rates' do
      VCR.use_cassette('exchange_rates_updater') do
        currencies = %w[EUR USD XYZ]
        response = exchange_rate_updater.get_exchange_rates('CZK', currencies)

        expect(response['EUR']).to eq(24.39)
        expect(response['USD']).to eq(22.442)
        expect(response['XYZ']).to be_nil
      end
    end

    it 'returns nil for a single currency with a non-existing value' do
      VCR.use_cassette('exchange_rates_updater') do
        non_existing_currency_value = 'XYZ'
        response = exchange_rate_updater.get_exchange_rates('CZK', [non_existing_currency_value])

        expect(response).to eq({ 'XYZ' => nil })
      end
    end
  end
end
