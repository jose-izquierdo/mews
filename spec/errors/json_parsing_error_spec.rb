# frozen_string_literal: true

RSpec.describe Errors::JsonParsingError do
  let(:error_code) { 'USD' }
  let(:error) { described_class.new(code: error_code) }

  it 'has the correct error message' do
    expect(error.message).to eq(format(Errors::ErrorMessages::JSON_PARSING_ERROR, code: error_code))
  end

  it 'logs the error' do
    expect { error.log_error }
      .to output(/#{Regexp.escape(format(Errors::ErrorMessages::JSON_PARSING_ERROR, code: error_code)).strip}/)
      .to_stdout
  end
end
