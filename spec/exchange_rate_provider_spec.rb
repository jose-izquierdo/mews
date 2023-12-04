# frozen_string_literal: true

RSpec.describe ExchangeRateProvider do
  let(:base_currency) { 'CZK' }
  let(:provider) { ExchangeRateProvider.new(base_currency) }
  let(:currencies) { %w[EUR JPY] }

  describe '#get_exchange_rates' do
    context 'with a valid base currency' do
      before do
        allow(provider).to receive(:valid_base_currency?).and_return(true)
      end

      context 'when cache is not expired' do
        before do
          VCR.use_cassette('exchange_rates_provider') do
            provider.send(:update_exchange_rates)
          end
        end

        it 'does not fetch new exchange rates' do
          expect(provider.instance_variable_get(:@fetcher)).not_to receive(:fetch_exchange_rates)
          provider.get_exchange_rates(currencies)
        end

        it 'returns exchange rates from cache' do
          result = provider.get_exchange_rates(currencies)
          expect(result).to eq({ 'EUR' => 24.39, 'JPY' => 15.302 })
        end
      end

      context 'when cache is expired' do
        before do
          allow(provider).to receive(:expired_cache?).and_return(true)
        end

        it 'fetches new exchange rates' do
          VCR.use_cassette('exchange_rates_provider') do
            allow(provider.instance_variable_get(:@fetcher)).to receive(:fetch_exchange_rates).and_call_original
            provider.get_exchange_rates(currencies)
          end

          expect(provider.instance_variable_get(:@fetcher)).to have_received(:fetch_exchange_rates).once
        end

        it 'returns the newly fetched exchange rates' do
          VCR.use_cassette('exchange_rates_provider') do
            result = provider.get_exchange_rates(currencies)
            expect(result).to eq({ 'EUR' => 24.39, 'JPY' => 15.302 })
          end
        end
      end
    end

    context 'with an invalid base currency' do
      before do
        allow(provider).to receive(:valid_base_currency?).and_return(false)
      end

      it 'does not fetch new exchange rates' do
        expect(provider.instance_variable_get(:@fetcher)).not_to receive(:fetch_exchange_rates)
        provider.get_exchange_rates(currencies)
      end

      it 'logs an error and returns nil' do
        allow(provider).to receive(:log_error)
        result = provider.get_exchange_rates(currencies)
        expect(result).to be_nil
        expect(provider).to have_received(:log_error).once
      end
    end
  end
end
