require 'rails_helper'

RSpec.describe Client, type: :model do
  describe "scope" do
    let(:client_1) { create(:client, status: 1) }
    let(:client_2) { create(:client, status: 0) }

    it "show active clients" do
      expect(Client.actives).to contain_exactly(client_1)
    end
  end

  describe 'relations' do
    it { is_expected.to belong_to(:zone) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:cliente) }
    it { is_expected.to validate_presence_of(:rif) }
    it { is_expected.to validate_presence_of(:saint_id) }
  end

  describe "#salesman" do
    let(:user) { create(:salesman) }
    let(:zone) { create(:zone, user: user) }
    let(:client) { create(:client, zone: zone)}
    subject { client.salesman }

    it { is_expected.to eql(user) }
  end

  describe 'block!' do
    let(:client) { create(:client_active) }

    it "can block user" do
      expect(client.active?).to be true
      client.block!
      expect(client.inactive?).to be true
    end

  end

end
