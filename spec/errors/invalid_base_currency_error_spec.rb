# frozen_string_literal: true

RSpec.describe Errors::InvalidBaseCurrencyError do
  let(:error_code) { 'USD' }
  let(:error) { described_class.new(code: error_code) }

  it 'has the correct error message' do
    expect(error.message).to eq(format(Errors::ErrorMessages::INVALID_BASE_CURRENCY, code: error_code))
  end

  it 'logs the error' do
    expect { error.log_error }
      .to output(/#{Regexp.escape(format(Errors::ErrorMessages::INVALID_BASE_CURRENCY, code: error_code)).strip}/)
      .to_stdout
  end
end
