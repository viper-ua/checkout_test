require_relative 'checkout'

pricing = {
  FR1: '(x / 2 + x % 2) * 3.11',
  SR1: 'x < 3 ? x * 5.00 : x * 4.50',
  CF1: 'x * 11.23'
  }

describe 'Checkout process' do
  it 'should return 22.45 to basket %w{FR1 SR1 FR1 FR1 CF1}' do
    items = %w{FR1 SR1 FR1 FR1 CF1}
    co = Checkout.new(pricing)
    items.each {|item| co.scan(item)}
    expect(co.total).to eq(22.45)
  end

  it 'should return 3.11 for basket %w{FR1 FR1}' do
    items = %w{FR1 FR1}
    co = Checkout.new(pricing)
    items.each {|item| co.scan(item)}
    expect(co.total).to eq(3.11)
  end

  it 'should return 16.61 for basket %w{SR1 SR1 FR1 SR1}' do
    items = %w{SR1 SR1 FR1 SR1}
    co = Checkout.new(pricing)
    items.each {|item| co.scan(item)}
    expect(co.total).to eq(16.61)
  end
end