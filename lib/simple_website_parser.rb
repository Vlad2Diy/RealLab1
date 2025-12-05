require 'mechanize'
require 'uri'
require 'fileutils'
require_relative 'item'
require_relative 'logger_manager'

module MyDovhyiApp
  class SimpleWebsiteParser
    attr_reader :config, :agent, :item_collection

    def initialize(config)
      @config = config
      @agent = Mechanize.new
      @item_collection = []
      FileUtils.mkdir_p('media')
    end

    def start_parse
      page = agent.get(config['start_page'])
      products = page.search(config['product_selector'])
      products.each { |p| parse_product(p) }
    end

    private

    def parse_product(product)
      title = product.at(config['title_selector'])&.text&.strip || 'Unknown Product'
      price = product.at(config['price_selector'])&.text&.strip || '0'
      category = product.at(config['category_selector'])&.text&.strip || 'Unknown Category'
      img_src = product.at(config['image_selector'])&.attr('src')
      image_path = ''

      if img_src
        img_url = URI.join(config['start_page'], img_src).to_s
        ext = File.extname(img_url).split('?').first
        safe_title = title.gsub(/[^0-9A-Za-z.\-]/, '_')
        image_path = File.join('media', "#{safe_title}#{ext}")
        begin
          agent.get(img_url).save(image_path)
          LoggerManager.info("Downloaded image: #{image_path}")
        rescue => e
          LoggerManager.error("Failed to download image #{img_url}: #{e.message}")
        end
      end

      item = Item.new(title: title, price: price, category: category, image_path: image_path)
      @item_collection << item
      LoggerManager.log_processed_file("Parsed item: #{title}")
    end
  end
end
