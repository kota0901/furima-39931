class Item < ApplicationRecord
  validates :image, presence: true
  validates :item_name, presence: true
  validates :description, presence: true
  validates :category_id,:condition_id, :deadline_id, :delivery_fee_payment_id, :region_id, presence: true, numericality: { other_than: 1 }
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }


  belongs_to :user
  has_one_attached :image
  has_one :order


  extend ActiveHash::Associations::ActiveRecordExtensions 
  belongs_to :category
  belongs_to :condition
  belongs_to :deadline
  belongs_to :delivery_fee_payment
  belongs_to :region  
end