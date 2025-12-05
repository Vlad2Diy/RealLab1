require_relative 'app_config_loader'
require_relative 'logger_manager'

loader = MyDovhyiApp::AppConfigLoader.new
loader.load_libs
config = loader.config('config/yaml_config/default_config.yaml', 'config/yaml_config')
loader.pretty_print_config_data

MyDovhyiApp::LoggerManager.init_logger(config)
MyDovhyiApp::LoggerManager.log_processed_file("Test message")
MyDovhyiApp::LoggerManager.log_error("Test error")

d