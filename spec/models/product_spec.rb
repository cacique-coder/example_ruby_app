require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validations' do
    subject { product.errors.keys }

     context 'negative price' do
      let(:product) { build(:product, price: -1) }
      before { product.valid? }

      it { is_expected.to include(:price) }
    end
    context 'zero price' do
      let(:product) { build(:product, price: 0) }
      before { product.valid? }

      it { is_expected.to include(:price) }
    end
    context 'zero price' do
      let(:product) { build(:product, price: 0.01) }
      before { product.valid? }

      it { is_expected.to_not include(:price) }
    end
  end

  describe 'scope' do
    describe "::available" do
      let(:product_1) { create(:product, units: 1) }
      let(:product_2) { create(:product, units: 3) }
      let(:product_3) { create(:product, units: 5) }

      it { expect(Product.available).to contain_exactly(product_2, product_3) }
    end
  end
  describe "as_json" do
    let(:product_1) { create(:product, units: 1, price: 20.50) }
    let(:json) { product_1.as_json }
    it do
      expect(json['price']).to eql(20.50)
    end
  end
end
