require_relative '../../lib/price_calculator'
require 'json'

describe PriceCalculator do
  before do
    file = File.read('public/offers.json')
    @products = JSON.parse(file).values
  end

  let(:calculator) { PriceCalculator.new(@products) }

  describe '#calculate_total' do
    context 'when the cart is empty' do
      it 'returns 0.0' do
        expect(calculator.calculate_total([])).to eq(0.0)
      end
    end

    context 'when products have no offers' do
      it 'calculates the total price correctly' do
        products = [
          { 'code' => 'GR1', 'name' => 'Green tea', 'price' => 3.11, 'offer' => {} },
          { 'code' => 'SR1', 'name' => 'Strawberries', 'price' => 5.00, 'offer' => {} }
        ]
        expect(calculator.calculate_total(products)).to eq(8.11)
      end
    end

    context 'when applying Buy-One-Get-One-Free offer' do
      it 'applies the offer correctly for even quantities' do
        cart = Array.new(4) { @products[0] } # 4 Green teas
        expect(calculator.calculate_total(cart)).to eq(6.22)
      end

      it 'applies the offer correctly for odd quantities' do
        cart = Array.new(3) { @products[0] } # 3 Green teas
        expect(calculator.calculate_total(cart)).to eq(6.22)
      end
    end

    context 'when applying bulk discount offer' do
      it 'applies the discount when threshold is met' do
        cart = Array.new(3) { @products[1] } # 3 Strawberries
        expect(calculator.calculate_total(cart)).to eq(13.50)
      end

      it 'does not apply the discount when threshold is not met' do
        cart = Array.new(2) { @products[1] } # 2 Strawberries
        expect(calculator.calculate_total(cart)).to eq(10.00)
      end
    end

    context 'when applying volume discount offer' do
      it 'applies the discount when threshold is met' do
        cart = Array.new(3) { @products[2] } # 3 Coffees
        expect(calculator.calculate_total(cart)).to eq(22.46)
      end

      it 'does not apply the discount when threshold is not met' do
        cart = Array.new(2) { @products[2] } # 2 Coffees
        expect(calculator.calculate_total(cart)).to eq(22.46)
      end
    end
  end

  describe '#apply_bogo_offer' do
    context 'check apply_bogo_offer method' do
      it 'applies the offer on green tea' do
        expect(calculator.send(:apply_bogo_offer, @products[0], 3)).to eq(6.22)
      end
    end
  end

  describe '#apply_bulk_discount_offer' do
    context 'check bulk offer method' do
      it 'applies the offer on strawberries when threshold passes' do
        expect(calculator.send(:apply_bulk_discount_offer, @products[1], 6, @products[1]['offer'])).to eq(27.0)
      end

      it 'applies the offer on strawberries when threshold does not pass' do
        expect(calculator.send(:apply_bulk_discount_offer, @products[1], 2, @products[1]['offer'])).to eq(10.0)
      end
    end
  end

  describe '#apply_volume_discount_offer' do
    context 'check apply_volume_discount_offer method' do
      it 'applies the offer on coffee when threshold passess' do
        expect(calculator.send(:apply_volume_discount_offer, @products[2], 6,
                               @products[2]['offer']).round(2)).to eq(44.92)
      end

      it 'applies the offer on coffee when threshold does not passess' do
        expect(calculator.send(:apply_volume_discount_offer, @products[2], 2, @products[2]['offer'])).to eq(22.46)
      end
    end
  end
end
