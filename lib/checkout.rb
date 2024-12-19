class Checkout
  require 'json'
  require_relative '../lib/price_calculator'

  def initialize
    file = File.read('public/offers.json')
    data = JSON.parse(file)
    @products = data
    @cart = []
    @price_calculator = PriceCalculator.new(data.values)
  end

  def scan(product_code)
    product = @products[product_code]
    unless product
      puts "Product code #{product_code} not found."
      return 
    end

    @cart << product
  end

  def total
    @price_calculator.calculate_total(@cart)
  end
end