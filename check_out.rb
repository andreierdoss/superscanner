class CheckOut
  attr_accessor :rules, :items, :total

  def initialize rules
    @rules = rules
    @items = []
    @total = 0
  end

  def scan item
    @items << item
    calculate_total
  end

  private
  def calculate_total
    rules.each {|rule| rule.apply_to(@items) if rule.valid? } if rules
    @total = @items.map {|item| item.discounted_unit_price || item.unit_price }.inject(0, :+)
  end
end
