require 'rails_helper'
RSpec.describe Zone, type: :model do
  describe "relations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to have_many(:clients) }
  end
end
