require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    subject { User.new }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:login) }
    it { is_expected.to validate_presence_of(:saint_id) }
  end

  describe 'block!' do
    let(:user) { create(:user_active) }

    it "can block user" do
      expect(user.active?).to be true
      user.block!
      expect(user.inactive?).to be true
    end

  end
  describe '#guest?' do
    let(:user) { build(:user) }
    subject { user.guest? }

    it { is_expected.to be false }
  end

  describe "::custom_authentication" do
    let!(:user) {create(:user, login: 'vendedor', password: '12345', token: '')}
    let(:user_authenticated) { User.custom_authentication(params) }

    describe 'not login, not password' do
      let(:params) { {login: '', password: ''} }
      it "don't return user" do
        expect(user_authenticated).to be_nil
      end
    end

    describe 'login and password' do
      let(:params) { {login: 'vendedor', password: '12345' }  }
      let(:user_cases) { create(:user, login: "NewSales", password: 'ABCD') }

      it "return a user with the same login" do
        expect(user_authenticated.login).to eql('vendedor')
      end

      it 'has a token' do
        expect(user_authenticated.token).not_to eql('')
        expect(user_authenticated.token).not_to be_nil
      end

      it "case sensitive" do
        expect(user_cases.login).to eql('newsales')
        expect( User.custom_authentication(login: 'newsalES', password:'abcd')).to eql(user_cases)
      end
    end
  end

  describe 'generate_token!' do
    let!(:user) {create(:user, login: 'vendedor', password: '12345', token: '')}
    it 'generate a valid token' do
      expect(user.token).to eql('')
      user.generate_token!
      user.reload
      expect(user.token).not_to eql('')
    end
  end
end
