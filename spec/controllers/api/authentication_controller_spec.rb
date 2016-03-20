require 'rails_helper'

RSpec.describe Api::AuthenticationController, type: :controller do
  let!(:user) { create(:user, login: 'vendedor', password: '123456') }

  describe 'POST login' do
    describe 'correct authentication' do
      it do
        xhr :post, :login, user: {login: 'vendedor', password: '123456'}
        json = JSON.parse(response.body)
        expect(json.keys).to include('token')
      end
    end
    describe 'not valid params' do
      it do
        xhr :post, :login, user: {login: '', password: '123456'}
        expect(response.code).to eql("422")
      end
    end
  end
end
