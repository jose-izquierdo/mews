# frozen_string_literal: true

RSpec.describe ExchangeRateFetcher do
  let(:base_currency) { 'CZK' }
  let(:fetcher) { ExchangeRateFetcher.new(base_currency) }

  describe '#fetch_exchange_rates' do
    it 'fetches exchange rates from the API' do
      VCR.use_cassette('exchange_rates_fetcher') do
        result = fetcher.fetch_exchange_rates

        expect(result).not_to be_nil
        expect(result).to be_a(Hash)
        expect(result['rates']).to be_a(Array)
      end
    end

    it 'handles JSON parsing errors' do
      allow(Net::HTTP).to receive(:get_response).and_return(
        double(:response, is_a?: Net::HTTPSuccess, body: 'invalid JSON')
      )

      expect { fetcher.fetch_exchange_rates }.not_to raise_error
      expect { fetcher.fetch_exchange_rates }.to output(/Error parsing JSON/).to_stdout
    end
  end
end
