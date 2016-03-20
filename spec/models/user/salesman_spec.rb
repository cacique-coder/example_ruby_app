require 'rails_helper'

RSpec.describe User::Salesman, type: :model do
  describe 'relations' do
    it { is_expected.to have_many(:clients).through(:zones) }
    it { is_expected.to have_many(:zones) }
    it { is_expected.to have_many(:orders) }
  end
end
