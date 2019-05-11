class CartSerializer < ActiveModel::Serializer
  attributes

  has_many :items
  has_many :discounts
end
