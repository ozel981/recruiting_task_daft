
class ItemsQuery
    def self.find_by_product_id(id)
      Item.find_by(product_id: id)
    end

    def self.find_by_id(id)
        Item.find_by(id: id)
    end
  end