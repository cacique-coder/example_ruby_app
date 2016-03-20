require 'rails_helper'

describe OrderDecorator do
  describe "#review_class" do

    it "order processed not return class" do
      order = create(:order, review: 1).decorate
      expect(order.review_class).to be_nil
    end

    it "order processed return order-not-process" do
      order = create(:order, review: 0).decorate
      expect(order.review_class).to eql('order-not-process')
    end
  end
end
