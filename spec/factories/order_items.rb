FactoryGirl.define do
  factory :order_item, :class => 'Order::Item' do
    association :order
    association :product
    quantity 1
  end

end
