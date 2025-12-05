require 'logger'
require_relative 'app_config_loader'

module MyDovhyiApp
  class LoggerManager
    @logger = nil

    class << self
      attr_reader :logger

      def init_logger
        loader = AppConfigLoader.new
        config = loader.get('logging') || {}
        log_file = config['file'] || 'logs/app.log'
        Dir.mkdir('logs') unless Dir.exist?('logs')
        @logger = Logger.new(log_file)
        @logger.level = Logger::INFO
        @logger.info("Logger initialized")
      end

      def info(msg); @logger.info(msg) if @logger; end
      def error(msg); @logger.error(msg) if @logger; end
      def log_processed_file(msg); @logger.info(msg) if @logger; end
    end
  end
end
