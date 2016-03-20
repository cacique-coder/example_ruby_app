require 'rails_helper'

RSpec.describe Order, type: :model do
  let!(:iva) { IVA.create(id: 1, percent: 0.10) }
  let(:discount) { create(:discount, percent: 0.00) }


  describe "validate orders" do
    it {is_expected.to validate_presence_of(:client)}

    describe 'The same salesperson couldn\'t save the same order' do
      let(:product) { create(:product, code: 'code')}
      let(:product_2) { create(:product, code: 'code_2')}
      let(:order_item) { build(:order_item, product: product, quantity: '12', price: 1000, order: nil) }
      let(:order_item_2) { build(:order_item, product: product, quantity: '12', price: 1000, order: nil) }
      let(:order_item_3) { build(:order_item, product: product, quantity: '12', price: 1000, order: nil) }
      let(:order_item_4) { build(:order_item, product: product_2, order: nil) }
      let(:client) { create(:client) }
      let(:order_1) { build(:order, client_id: client.id, items: [order_item] )}
      let(:order_2) { build(:order, client_id: client.id, items: [order_item_2] )}
      let(:order_3) { build(:order, client_id: client.id, items: [order_item_3, order_item_2]) }

      it "orders repeated will not created" do
        expect { order_1.save }.to change{ Order.count }.from(0).to(1)
        expect { order_2.save }.to_not change{ Order.count }
        expect { order_3.save }.to change{ Order.count }.from(1).to(2)
      end
    end
  end
  describe "review_orders" do
    let(:product) { create(:product) }
    let(:items) { build_list(:order_item, 1, product: product, order: nil) }
    let!(:order_1) { create(:order, review: false) }
    let!(:order_2) { create(:order, review: false, items: items ) }

    let(:params) {
      {"order_id"=> "#{order_1.id}", "status"=>"ok", "saint_code"=>"015024"}
     }

    before { Order.review_orders(params) }

    it "first_order should be reviewed " do
      order_1.reload
      expect(order_1.processed?).to be_truthy
    end
    it "second_order should be pending " do
      order_2.reload
      expect(order_2.processed?).to be_falsey
    end

  end
  describe '#review!' do
    let(:order) { create(:order, review: false) }

    it { expect { order.review! }.to change{ order.processed? }.from(false).to(true)   }
  end

  describe '#iva' do
    before { allow_any_instance_of(Order::Item).to(
      receive(:total).and_return(10)) }

    let(:order) { create(:order, items: create_list(:order_item, 2),
                         discount: 0 ) }

    subject { order.iva }

    it{ is_expected.to eql(2.0) }
  end

  describe '#total' do
    before { allow_any_instance_of(Order::Item).to(
      receive(:total).and_return(10)) }

    let(:order) { create(:order, items: create_list(:order_item, 2),
                         discount: 0.05 ) }
    subject { order.total }

    it { is_expected.to eql(21.0) }

  end

  describe '#subtotal' do
    before { allow_any_instance_of(Order::Item).to(
      receive(:total).and_return(10)) }
    subject { order.subtotal }

    context 'not discount' do
      let(:order) { create(:order, items: create_list(:order_item, 2),
                           discount: 0 ) }
      it { is_expected.to eql(20.0) }
    end
    context 'with discount' do

      let(:order) { create(:order, items: create_list(:order_item, 2),
                           discount: 0.15 ) }
      it { is_expected.to eql(17.0) }
    end
  end

  describe '#processed?' do
    subject { order.processed? }
    context 'not reviewed' do
      let(:order) { create(:order, review: 0) }

      it { is_expected.to eql(false) }
    end
    context 'reviewed' do
      let(:order) { create(:order, review: true) }

      it { is_expected.to eql(true) }

    end
  end

  describe '#pending?' do
    subject { order.pending? }
    context 'not reviewed' do
      let(:order) { create(:order, review: false) }
      it { is_expected.to eql(true) }
    end
    context 'reviewed' do
      let(:order) { create(:order, review: true) }
      it { is_expected.to eql(false) }
    end
  end
  describe '::pending' do

    let(:product) { create(:product) }
    let(:items) { build_list(:order_item, 1, product: product, order: nil) }


    let!(:pending_order) { create(:order, review: false) }
    let!(:order) { create(:order, review: true, items: items) }
    it { expect(Order.pending).to contain_exactly(pending_order) }
  end

  describe "as_json" do
    let(:order) {create(:order, items: items) }
    let(:item) { order.items.first }
    let(:product) { create(:product) }
    let(:items) { build_list(:order_item, 1, product: product, order: nil) }
    subject(:json) { order.as_json }

    it do
      expect(json['client_name']).to eql(order.client.name)
      expect(json['items'].size).to eql(order.items.size)
      expect(json['items'][0]['description']).to eql(item.description)
      expect(json['items'][0]['trademark']).to eql(item.trademark)
    end

  end
end
