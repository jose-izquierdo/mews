# frozen_string_literal: true

require 'logger'
require_relative 'error_messages'

module Errors
  class ErrorHandler
    attr_reader :message

    def initialize(message)
      @message = message
    end

    def log_error
      logger.error(message)
    end

    private

    def logger
      @logger ||= Logger.new($stdout)
    end
  end
end
