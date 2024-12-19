require_relative 'lib/checkout'

#initialize the checkout class
checkout = Checkout.new

#scan products
checkout.scan('GR1')
checkout.scan('SR1')
checkout.scan('GR1')
checkout.scan('GR1')
checkout.scan('CF1')

#calculate total
total_price = checkout.total
puts "Total price: €#{'%.2f' %total_price}"

#initialize the checkout class
checkout = Checkout.new

#scan products
checkout.scan('GR1')
checkout.scan('GR1')

#calculate total
total_price = checkout.total
puts "=========NEW CART======"
puts "Total price: €#{'%.2f' %total_price}"


#initialize the checkout class
checkout = Checkout.new

#scan products
checkout.scan('SR1')
checkout.scan('SR1')
checkout.scan('GR1')
checkout.scan('SR1')

#calculate total
total_price = checkout.total
puts "=========NEW CART======"
puts "Total price: €#{'%.2f' %total_price}"

#initialize the checkout class
checkout = Checkout.new

#scan products
checkout.scan('GR1')
checkout.scan('CF1')
checkout.scan('SR1')
checkout.scan('CF1')
checkout.scan('CF1')

#calculate total
total_price = checkout.total
puts "=========NEW CART======"
puts "Total price: €#{'%.2f' %total_price}"