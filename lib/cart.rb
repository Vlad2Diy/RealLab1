require 'json'
require 'csv'
require 'yaml'
require_relative 'item'
require_relative 'item_container'
require_relative 'database_connector'

module MyDovhyiApp
  class Cart
    include ItemContainer

    def initialize
      @items = []
      Dir.mkdir("output") unless Dir.exist?("output")
      @db = DatabaseConnector.new
    end

    def save_all
      save_txt
      save_json
      save_csv
      save_yaml
      save_sqlite
    end

    def save_txt
      File.write("output/items.txt", @items.map(&:to_s).join("\n"))
    end

    def save_json
      File.write("output/items.json", JSON.pretty_generate(@items.map(&:to_h)))
    end

    def save_csv
      CSV.open("output/items.csv", 'w') do |csv|
        csv << %w[title price category image_path]
        @items.each { |i| csv << [i.title, i.price, i.category, i.image_path] }
      end
    end

    def save_yaml
      File.write("output/items.yaml", @items.map(&:to_h).to_yaml)
    end

    def save_sqlite
      @items.each { |i| @db.save_item(i) }
    end
  end
end
