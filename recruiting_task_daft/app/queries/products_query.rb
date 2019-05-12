class ProductsQuery
    def self.all
      Product.all
    end

    def self.find_by_id(id)
      Product.find_by(id: id)
    end
end