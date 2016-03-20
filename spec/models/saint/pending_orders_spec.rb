  require 'rails_helper'

RSpec.describe Saint::PendingOrders, type: :model do

  let(:client) { create(:client, saint_id: '0210') }
  let(:salesman) { create(:salesman, saint_id: '20')  }
  let(:product) { create(:product, code: "29377") }
  let(:product_in_order) { create(:order_item, product: product, quantity: 12, order: order) }

  let(:order) { create(:order,
                       review: false,
                       client: client,
                       user: salesman,
                       discount: '0.05',
                       comentario:"")
  }
  let(:pending_orders) { Saint::PendingOrders.new }

  before { DatabaseCleaner.clean }
  it do
    product_in_order
    expect(pending_orders.hash).to eql(result_expected)
  end

  let (:result_expected) do
    { order.id.to_s =>
      {
        "CODCLIE" => "0210",
        "CODVEND" => "20",
        "descuento" => "0.05",
        "comentario" => "",
        "products" => [
          "CODPROD": "29377",
          "CANT": "12"
        ]
      }
    }
  end
end
