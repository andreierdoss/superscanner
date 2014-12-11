class Rule
  attr_accessor :item_sku, :quantity, :bulk_price, :discounted_unit_price, :start_date, :end_date

  def initialize attributes
    @item_sku = attributes[:item_sku]
    @quantity = attributes[:quantity]
    @bulk_price = attributes[:bulk_price]
    @discounted_unit_price = @bulk_price.to_f / @quantity
    @start_date = attributes[:start_date]
    @end_date = attributes[:end_date]
  end

  def apply_to items
    applicable_items(items).each {|item| item.discounted_unit_price = @discounted_unit_price }
    items
  end

  def valid?
    (start_date..end_date).cover?(Date.today)
  end

  private
  def applicable_items items
    rule_items = sku_filtered_items(items)
    rule_items.first(applicable_total(rule_items.count))
  end

  def applicable_total count
    count / quantity * quantity
  end

  def sku_filtered_items items
    items.select {|item| item.sku == item_sku}
  end
end
