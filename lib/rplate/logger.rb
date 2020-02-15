# frozen_string_literal: true

module RPlate
  # The Logger class is responsible for logging messages
  class Logger
    class << self
      attr_reader :logger

      def configure(logger: ::Logger.new(STDOUT))
        @logger = logger
      end

      def info(message)
        logger.info("#{message}\n")
      end
    end

    configure
  end
end
