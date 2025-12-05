require 'sqlite3'

module MyDovhyiApp
  class DatabaseConnector
    DB_PATH = "data/items.db"

    def initialize
      Dir.mkdir("data") unless Dir.exist?("data")
      @db = SQLite3::Database.new(DB_PATH)
      create_table
    end

    def create_table
      @db.execute <<~SQL
        CREATE TABLE IF NOT EXISTS items (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          price TEXT,
          category TEXT,
          image_path TEXT
        );
      SQL
    end

    def save_item(item)
      @db.execute(
        "INSERT INTO items (title, price, category, image_path) VALUES (?, ?, ?, ?)",
        [item.title, item.price, item.category, item.image_path]
      )
    end
  end
end
