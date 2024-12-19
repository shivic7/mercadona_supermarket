class PriceCalculator

  def initialize(products)
    @products = products
  end

  def calculate_total(cart)
    total_price = 0
    product_groups = cart.group_by { |product| product["code"] }
    product_groups.values.each do |products|
      product = products.first
      offer = product["offer"]
      total_price += product_total_price(product, products.size, offer)
    end
    total_price.round(2)
  end

  private

  def product_total_price(product, quantity, offer)
    case offer["type"]
    when 'bogo'
      apply_bogo_offer(product, quantity)
    when 'bulk_discount'
      apply_bulk_discount_offer(product, quantity, offer)
    when 'volume_discount'
      apply_volume_discount_offer(product, quantity, offer)
    else
      product["price"] * quantity
    end
  end

  def apply_bogo_offer(product, quantity)
    (quantity / 2 + quantity % 2) * product["price"]
  end

  def apply_bulk_discount_offer(product, quantity, offer)
    if quantity >= offer["threshold"]
      offer["discounted_price"] * quantity
    else
      product["price"] * quantity
    end
  end

  def apply_volume_discount_offer(product, quantity, offer)
    if quantity >= offer["threshold"]
      discounted_price = product["price"] * (1 - offer["discount_percentage"] / 100.0)
      discounted_price * quantity
    else
      product["price"] * quantity
    end
  end
end
