class Item
  attr_accessor :sku, :unit_price, :discounted_unit_price

  def initialize attributes
    @sku = attributes[:sku]
    @unit_price = attributes[:unit_price]
  end
end
