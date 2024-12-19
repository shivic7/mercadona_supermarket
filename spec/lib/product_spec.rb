require_relative '../../lib/product'

describe Product do
  describe '#create product' do
    context 'when a new product is created' do
      it 'creates a product with a code, name, and price' do
        product = Product.new('GR1', 'Green tea', 3.11)
        expect(product.code).to eq('GR1')
        expect(product.name).to eq('Green tea')
        expect(product.price).to eq(3.11)
      end
    end
  end
end
