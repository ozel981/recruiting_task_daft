class ItemCreator
    def initialize(params)
      @params = params
    end
  
    def call
      create_item
    end

    private

    attr_accessor :params

    def create_item
        item_with_same_product = ItemsQuery.find_by_product_id(params[:product_id])
        if item_with_same_product
            new_params = {id: item_with_same_product.id, quantity: item_with_same_product.quantity}
            if !params.has_key?(:quantity)
                new_params[:quantity] += 1
            else
                item = cart.items.new(params)
                puts item.valid?
                if item.valid?
                    new_params[:quantity] += params[:quantity].to_i
                else
                    item_with_same_product.update!(params)
                end
            end
            ItemUpdater.new(new_params).call
        else
            cart.items.create!(params)
        end
    end

    def cart
        @cart ||= CartsQuery.get_cart
    end
end