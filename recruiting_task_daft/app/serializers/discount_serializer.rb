class DiscountSerializer < ActiveModel::Serializer
  attributes :id, :kind, :name, :product_ids, :count, :price
  def attributes(x,y)
    hash = super
    if hash[:count].nil?
      hash.delete(:count)
    end
    if hash[:price].nil?
      hash.delete(:price)
    end
   hash
  end
  belongs_to :cart
end
