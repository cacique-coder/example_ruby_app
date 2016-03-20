require 'rails_helper'

RSpec.describe SaintController, type: :controller do

  let!(:user) { create(:user, token: 'token') }
  let!(:discount_1) { create(:discount) }
  let!(:discount_2) { create(:discount, percent:0.5) }

  let(:order_1) { create(:order, review: false, items: []) }
  let(:order_2) { create(:order, review: false, items: []) }

  let(:params) do
    {
      "order" =>
        {"order_id"=> "#{order_1.id}", "status"=>"ok", "saint_code"=>"015024"}
    }
  end

  before do
    allow_any_instance_of(Order).to(
      receive(:order_not_repeated))
    order_1
    order_2
  end

  it "sincronization works" do
    xhr :post, :sincronize, params
    order_1.reload
    order_2.reload
    expect(order_1.processed?).to be_truthy
    expect(order_2.processed?).to be_falsey
  end

end
