FactoryBot.define do
  factory :purchase_address do
    token {"tok_abcdefghijk00000000000000000"}
    post_code { '111-1111' }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    city { Gimei.city.kanji }
    town_number { Gimei.town.to_s }
    building_name { Faker::Lorem.sentence }
    telephone_number { 11111111111 }
  end
end
