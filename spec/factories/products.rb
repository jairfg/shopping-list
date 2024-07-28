FactoryBot.define do
  factory :product do
    association :store_section
    name { Faker::Lorem.word }
    store_name { Faker::Lorem.word }
    purchased { false }
    purchase_date { Faker::Date.backward(days: 10) }
    quantity { Faker::Number.between(from: 1, to: 10).to_i }
    trait :invalid_character do
      name { Faker::Lorem.word + Faker::Base.regexify(/[%$&@+|]/) }
    end
  end
end
