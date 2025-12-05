# frozen_string_literal: true
require_relative 'cart'
require_relative 'simple_website_parser'
require_relative 'logger_manager'
require_relative 'database_connector'

module MyDovhyiApp
  class Engine
    attr_reader :config, :cart, :db

    def initialize(config)
      @config = config      # тепер це вже хеш з webparser конфігурацією
      @cart = Cart.new
      @db = DatabaseConnector.new
    end

    def run
      parser = SimpleWebsiteParser.new(@config)
      parser.start_parse

      parser.item_collection.each do |item|
        @cart.add_item(item)
        @db.save_item(item)  # save_item вже є в DatabaseConnector
      end

      @cart.save_all         # викликаємо метод збереження всього
    end
  end
end
