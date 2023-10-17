FactoryBot.define do
  factory :item do
    name { Faker::JapaneseMedia::Conan.character }
    description { Faker::JapaneseMedia::StudioGhibli.quote }
    unit_price { Faker::Number.within(range: 1..10) }
    merchant_id { Faker::Number.within(range: 1..10) }
  end
end