class Checkout
  attr_accessor :total
  def initialize(pricing_rules)
    @cart = Hash.new(0)
    @rules = Hash.new(->(_x) { 0 })
    pricing_rules.each do |item, rule|
      @rules[item] = eval "->(x) {#{rule}}"
    end
  end

  def scan(item)
    @cart[item.to_sym] += 1
    @total = cart_total
  end

  private

  def cart_total
    total = 0
    @cart.each { |item, quantity| total += @rules[item].call(quantity) }
    total
  end
end
