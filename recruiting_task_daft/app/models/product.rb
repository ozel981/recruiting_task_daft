class Product < ApplicationRecord
  has_one :item
  has_many :discount_product
  has_many :discounts, through: :discount_product

  validates :name, presence: true, uniqueness: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
