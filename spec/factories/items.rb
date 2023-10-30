FactoryBot.define do
  factory :item do
    item_name             { 'エアリアル' }
    description           { 'ガンダム' }
    price                 { 2480 }
    condition_id          { 2 }
    category_id           { 2 }
    delivery_fee_payment_id   { 2 }
    region_id             { 2 }
    deadline_id           { 2 }
    association :user
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.jpg'), filename: 'test_image.jpg', content_type: 'image/jpeg')
    end
  end
end