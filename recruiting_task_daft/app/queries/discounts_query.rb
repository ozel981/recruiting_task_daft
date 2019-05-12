
class DiscountsQuery
    def self.find_by_id(id)
        Discount.find_by(id: id)
    end
  end