require 'rails_helper'

RSpec.describe Order::Item, type: :model do

  it { is_expected.to delegate_method(:description).to(:product) }
  it { is_expected.to delegate_method(:trademark).to(:product) }
  it { is_expected.to delegate_method(:code).to(:product) }


  describe "price_cents" do
    let(:product) {create(:product, price: 20) }
    let(:item) { create(:order_item, quantity: 1, product: product) }

    subject{ item.price_cents }

    it { is_expected.to eql(2000) }
  end
  describe '#total' do
    context "quantity 1" do
      let(:product) {create(:product, price: 20) }
      let(:item) { create(:order_item, quantity: 1, product: product) }
      subject { item.total.to_f }

      it { is_expected.to eql(20.0) }
    end
    context "quantity 3" do
      let(:product) {create(:product, price: 30) }
      let(:item) { create(:order_item, quantity: 3, product: product) }
      subject { item.total.to_f }

      it { is_expected.to eql(90.00)}

    end
  end

  describe "as_json" do
    let(:product) { create(:product, price: 20.50) }
    let(:item) { create(:order_item, quantity: 1, product: product) }

    subject(:json) { item.as_json }

    it { expect(json['price']).to eql(20.50)}
    it { expect(json['trademark']).to eql(product.trademark)}
    it { expect(json['description']).to eql(product.description)}
  end
end
