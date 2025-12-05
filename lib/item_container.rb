module MyDovhyiApp
  module ItemContainer
    def add_item(item); @items << item; end
    def all; @items; end
    def size; @items.size; end
  end
end
