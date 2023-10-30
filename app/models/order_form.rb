class OrderForm
  include ActiveModel::Model

  attr_accessor :user_id, :item_id, :post_code, :region_id, :city, :banchi, :building_name, :number, :token

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :region_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :city
    validates :banchi
    validates :number, format: { with: /\A\d{10,11}\z/, message: 'is invalid. Input only number', allow_blank: true }
    validates :token
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(post_code: post_code, region_id: region_id, city: city, banchi: banchi, building_name: building_name, number: number, order_id: order.id)
  end
end