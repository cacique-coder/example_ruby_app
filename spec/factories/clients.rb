FactoryGirl.define do
  factory :client do
    association :zone
    cliente_optional ''
    direction ''
    rif 'j-1231234-4'
    telefono ''
    cliente 'client'
    description ''
    zona_postal '2'
    status 1
    sequence(:saint_id) { |x| x }
    factory :client_active do
      status 1
    end

  end
end

