module Carts
    class ItemsController < ApplicationController

        def create
            ItemCreator.new(item_params).call

            render json: cart
        end

        def update
            ItemUpdater.new(item_params).call

            render json: cart
        end


        private

        def cart
            @cart ||= CartsQuery.get_cart
        end
        
        def item_params
            params.permit(:id, :quantity, :product_id)
        end
    end
end
