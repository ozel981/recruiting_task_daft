class Item < ApplicationRecord
    belongs_to :cart
    belongs_to :product

    validates :quantity, numericality: {greater_than_or_equal_to: 0}
    validates :product_id, presence: true
end