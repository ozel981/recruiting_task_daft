class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :price 
  puts "sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss"
  has_one :item
end
