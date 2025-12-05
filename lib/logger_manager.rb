require 'logger'

module MyDovhyiApp
  class LoggerManager
    class << self
      attr_reader :logger

      def init_logger(config)
        dir = config['logging']['directory']
        Dir.mkdir(dir) unless Dir.exist?(dir)
        @logger = Logger.new("#{dir}/#{config['logging']['files']['application_log']}")
        @logger.level = Logger.const_get(config['logging']['level'])
      end

      def log_processed_file(msg)
        @logger.info(msg)
      end

      def log_error(msg)
        @logger.error(msg)
      end
    end
  end
end
