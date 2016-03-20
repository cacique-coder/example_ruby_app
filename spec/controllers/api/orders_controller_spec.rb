require 'rails_helper'

RSpec.describe Api::OrdersController, type: :controller do
  let(:order) { attributes_for(:order, client_id: client.id) }
  let(:client) { create(:client) }
  let!(:user) { create(:user_salesman, token: 'token') }

  before { expect_any_instance_of(Api::OrdersController).to receive(:authenticated_user!).and_return(user) }
  before { expect_any_instance_of(Api::OrdersController).to receive(:current_user).and_return(User::Salesman.first) }
  describe "create a order" do
    it "with client should be created" do
      expect do
        xhr :post, :create, order: order, authorization: ActionController::HttpAuthentication::Token.encode_credentials('token')
      end.to change { Order.count }.by(1)
    end
    it "with no valid client, it not created" do
      order[:client_id] = 0
      expect do
        xhr :post, :create, order: order, authorization: ActionController::HttpAuthentication::Token.encode_credentials('token')
      end.to change { Order.count }.by(0)
    end
  end
end
