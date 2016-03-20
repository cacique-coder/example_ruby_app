require 'rails_helper'

RSpec.describe Api::DiscountsController, type: :controller do
  let!(:user) { create(:user, token: 'token') }
  let!(:discount_1) { create(:discount) }
  let!(:discount_2) { create(:discount, percent:0.5) }

  it do
    xhr :get, :index
    expect(response.status).to eql(401)
  end

  xit "return all discounts avialables" do
    xhr :get, :index, authorization: ActionController::HttpAuthentication::Token.encode_credentials('token')
    json = JSON.parse(response.body)
    discount_ids = json.map{ |discount| discount['id_discount'] }
    expect(discount_ids).to contain_exactly(discount_1.id, discount_2.id)
  end
end
