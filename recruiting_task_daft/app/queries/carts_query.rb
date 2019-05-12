
class CartsQuery

    def self.get_cart
        if Cart.any?
            Cart.first
        else
            Cart.create
        end
    end
end