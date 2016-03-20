FactoryGirl.define do
  factory :order do
    association :user
    association :client
    discount 0.1
    comentario ""
  end

end
