class ItemSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :product
 
  def product
    {
      id: self.object.product.id,
      name: self.object.product.name,
      price: self.object.product.price
    }
  end

  belongs_to :product
  
end
