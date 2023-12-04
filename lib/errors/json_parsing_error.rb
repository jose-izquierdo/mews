# frozen_string_literal: true

require_relative 'error_handler'

module Errors
  class JsonParsingError < Errors::ErrorHandler
    def initialize(code:)
      super(format(Errors::ErrorMessages::JSON_PARSING_ERROR, code: code))
    end
  end
end
