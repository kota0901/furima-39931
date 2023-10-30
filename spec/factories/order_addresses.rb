FactoryBot.define do
  factory :order_address do
    post_code { '123-4567' }
    region_id { 2 }
    city { '東京都' }
    banchi { '1-1' }
    building_name { 'アパホテル' }
    number { 12345678910 }
    token {"tok_abcdefghijk00000000000000000"}



  end


end