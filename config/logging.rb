# frozen_string_literal: true

require "logger"

module Logging
  class << self
    attr_writer :logger
    def logger
      @logger ||= Logger.new($stdout)
    end
  end

  # Addition
  def self.included(base)
    class << base
      def logger
        Logging.logger
      end
    end
  end

  def logger
    Logging.logger
  end
end
