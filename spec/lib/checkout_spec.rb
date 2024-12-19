require_relative '../../lib/checkout'
require_relative '../../lib/price_calculator'

describe Checkout do

  let(:checkout) { Checkout.new }

  describe '#scan' do
    it 'adds a product to the cart' do
      checkout.scan('GR1')
      expect(checkout.instance_variable_get(:@cart).size).to eq(1)
    end

    it 'puts an error for an invalid product code' do
      expect{ checkout.scan('INVALID') }.to output("Product code INVALID not found.\n").to_stdout
    end
  end

  describe '#total' do
    context 'Checkout random cart total' do
      it 'calculates the total price for the cart with different products' do
        checkout.scan('GR1')
        checkout.scan('SR1')
        checkout.scan('GR1')
        checkout.scan('GR1')
        checkout.scan('CF1')
        expect(checkout.total).to eq(22.45)
      end
    end

    context 'Check Buy one get one offer' do
      it 'calculates the total price for green tea' do
        checkout.scan('GR1')
        checkout.scan('GR1')        
        expect(checkout.total).to eq(3.11)
      end
    end

    context 'Check Strawberries bulk offer' do
      it 'calculates the total price for Strawberries with other products' do
        checkout.scan('SR1')
        checkout.scan('SR1')
        checkout.scan('GR1')
        checkout.scan('SR1')
        expect(checkout.total).to eq(16.61)
      end
    end

    context 'Check Coffee volume offer' do
      it 'calculates the total price for coffee along with other products' do
        checkout.scan('GR1')
        checkout.scan('CF1')
        checkout.scan('SR1')
        checkout.scan('CF1')
        checkout.scan('CF1')
        expect(checkout.total).to eq(30.57)
      end
    end
  end
end
