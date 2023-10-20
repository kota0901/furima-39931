FactoryBot.define do
  factory :user do
    nickname {Faker::Name.name}
    last_name {"鈴木"}
    first_name {"一郎"}
    last_name_kana {"スズキ"}
    first_name_kana {"イチロウ"}
    birthday {Faker::Date.between(from: 10.days.ago, to: Date.today)}
    email {Faker::Internet.free_email}
    password { '1a' + Faker::Internet.password(min_length: 6) }
    password_confirmation {password}
  end
end