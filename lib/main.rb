# main.rb
require_relative 'app_config_loader'
require_relative 'logger_manager'
require_relative 'configurator'
require_relative 'engine'

begin
  # --- Завантаження конфігурації ---
  loader = MyDovhyiApp::AppConfigLoader.new
  config_data = loader.get('webparser')       # отримуємо потрібну секцію
  logging_config = loader.get('logging')

  # --- Ініціалізація логера ---
  MyDovhyiApp::LoggerManager.init_logger

  # --- Налаштування конфігуратора ---
  configurator = MyDovhyiApp::Configurator.new


  # --- Запуск двигуна ---
  engine = MyDovhyiApp::Engine.new(config_data)
  engine.run

rescue StandardError => e
  puts "Помилка під час запуску додатку: #{e.message}"
  MyDovhyiApp::LoggerManager.logger&.error("Помилка запуску: #{e.message}\n#{e.backtrace.join("\n")}")
end
