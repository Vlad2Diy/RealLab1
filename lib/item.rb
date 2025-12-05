module MyDovhyiApp
  class Item
    attr_accessor :title, :price, :category, :image_url, :image_path

    def initialize(title:, price:, category:, image_url: nil, image_path: nil)
      @title = title
      @price = price
      @category = category || "Unknown"
      @image_url = image_url
      @image_path = image_path
    end

    def to_h
      { title: @title, price: @price, category: @category, image_path: @image_path }
    end

    def to_s
      "#{@title}: #{@price} (#{@category})"
    end
  end
end
