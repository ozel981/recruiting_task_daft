module Carts
    class DiscountsController < ApplicationController

        def create
            DiscountCreator.new(discount_params).call

            render json: cart
        end

        def update
            DiscountUpdater.new(discount_params).call

            render json: cart
        end

        private

        def cart
            @cart ||= CartsQuery.get_cart
        end

        def discount_params
            params.permit(:id, :kind, :name, :price, :count, product_ids: [])
        end
    end
end
