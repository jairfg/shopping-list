require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      product = build(:product)
      expect(product).to be_valid
    end

    it 'is not valid without a name' do
      product = build(:product, name: nil)
      expect(product).to_not be_valid
    end

    it 'is not valid name with character "%$&@+|"' do
      product = build(:product, :invalid_character)
      expect(product).to_not be_valid
    end

    it 'is not valid with a name longer than 128 characters' do
      product = build(:product, name: "a" * 129)
      expect(product).to_not be_valid
    end

    it 'is not valid with a negative quantity' do
      product = build(:product, quantity: -1)
      expect(product).to_not be_valid
    end
  end

  describe 'scopes' do
    it 'returns products pending purchase ordered by ascending date' do
      product1 = create(:product, purchase_date: Date.today)
      product2 = create(:product, purchase_date: Date.yesterday)

      # Create a product with purchased: true
      create(:product, purchased: true, purchase_date: Date.today)

      expect(Product.pending_purchase).to eq([product2, product1])
    end
  end

  describe 'custom methods' do
    it 'groups pending purchase products by date' do
      product1 = create(:product, purchase_date: Date.today)
      product2 = create(:product, purchase_date: Date.yesterday)
      product3 = create(:product, purchase_date: Date.today)

      group_products = Product.hash_date_products
      # { date_yesterday: [products], date_today: [products] }

      expect(group_products.keys).to contain_exactly(Date.today, Date.yesterday)
      expect(group_products[Date.today]).to contain_exactly(product1, product3)
      expect(group_products[Date.yesterday]).to contain_exactly(product2)
    end

    it 'returns true when there are pending purchases for a given date' do
      product = create(:product, purchased: false)
      result = Product.pending_purchase?(product.purchase_date)
      expect(result).to be true
    end

    it 'returns false when there are no pending purchases for a given date' do
      product = create(:product, purchased: true)
      result = Product.pending_purchase?(product.purchase_date)
      expect(result).to be false
    end
  end
end
