require_relative 'checkout'

pricelist = {
  FR1: 3.11,
  SR1: 5.00,
  CF1: 11.23
}

pricing = [
  Proc.new do |cart, prices|
    disc = 0
    cart.each { |item, qty| disc += qty / 2 * prices[item] if item == :FR1 }
    disc
  end, 
  Proc.new do |cart, prices|
     disc = 0
     cart.each { |item, qty| disc += qty * (prices[item] - 4.50) if (item == :SR1) && (qty > 2) }
     disc
  end
]

# Baskets and expected totals
test_set = {
  %w[FR1 SR1 FR1 FR1 CF1] => 22.45,
  %w[FR1 FR1] => 3.11,
  %w[SR1 SR1 FR1 SR1] => 16.61,
  %w[] => 0
}

describe 'Checkout process' do
  test_set.each do |items, total_exp| 
    it "should return #{total_exp} to basket #{items}" do
      co = Checkout.new(pricelist, pricing)
      items.each { |item| co.scan(item) }
      expect(co.total).to eq(total_exp)
    end
  end
end
