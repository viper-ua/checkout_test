class Checkout
  def initialize(prices, pricing_rules)
    @cart = Hash.new(0)
    @pricelist = prices
    @pricing_rules = pricing_rules
  end

  def scan(item)
    @cart[item.to_sym] += 1
  end

  def total
    total, discount = 0.00, 0.00
    @cart.each do |item, quantity|
      total += @pricelist[item] * quantity
    end
    @pricing_rules.each { |rule| discount += rule.call(@cart, @pricelist) }
    @total = (total - discount).round(2)
  end
end
