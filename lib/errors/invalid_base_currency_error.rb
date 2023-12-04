# frozen_string_literal: true

require_relative 'error_handler'

module Errors
  class InvalidBaseCurrencyError < Errors::ErrorHandler
    def initialize(code:)
      super(format(Errors::ErrorMessages::INVALID_BASE_CURRENCY, code: code))
    end
  end
end
