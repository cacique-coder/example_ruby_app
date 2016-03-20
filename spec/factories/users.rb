FactoryGirl.define do
  factory :user do
    name 'Daniel Zambrano'
    sequence(:saint_id) { |n| n }
    login 'danielz'
    email 'daniel@email.com'
    type 'User'
    status 1
    token 0
    factory :user_active do
      status 1
    end
    factory :salesman do
      factory :user_salesman do
        type 'User::Salesman'
      end
    end
  end

end
