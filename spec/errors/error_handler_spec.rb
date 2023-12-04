# frozen_string_literal: true

RSpec.describe Errors::ErrorHandler do
  let(:error_message) { 'Test error message' }
  let(:error_handler) { described_class.new(error_message) }

  it 'has the correct error message' do
    expect(error_handler.message).to eq(error_message)
  end

  it 'logs the error' do
    allow($stdout).to receive(:puts)
    expect { error_handler.log_error }.to output(/#{error_message}/).to_stdout
  end

  it 'uses a Logger instance' do
    expect(error_handler.send(:logger)).to be_an_instance_of(Logger)
  end
end
