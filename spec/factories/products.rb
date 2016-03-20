FactoryGirl.define do
  factory :product do
    price 1.0
    sequence(:code) { |n| "CGR-#{n}-#{Faker::StarWars.droid }"}
    trademark 'Chevrolet'
    description 'Some description'
  end

end
