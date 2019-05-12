class DiscountCreator
    def initialize(params)
      @params = params
    end
  
    def call
      create_discount
    end

    private

    attr_reader :params

    def create_discount
      cart.discounts.create!(params)
    end

    def cart
      @cart ||= CartsQuery.get_cart
    end
end