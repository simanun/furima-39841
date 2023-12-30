FactoryBot.define do
  factory :user do
    nickname { Gimei.name.first.kanji }
    email { Faker::Internet.email }
    password { "1a#{Faker::Internet.password(min_length: 6)}" }
    password_confirmation { password }
    last_name { Gimei.name.last.kanji }
    first_name { Gimei.name.first.kanji }
    last_name_kana { Gimei.name.last.katakana }
    first_name_kana { Gimei.name.first.katakana }
    birthday { Faker::Date.birthday(min_age: 18, max_age: 65) }
  end
end
