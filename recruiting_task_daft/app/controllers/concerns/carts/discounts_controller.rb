module Carts
    class DiscountsController < ApplicationController
        before_action :prepare_cart

        def create
            cart.discounts.create!(discount_params)

            render json: cart
        end

        def update
            discount.update!(discount_params)

            render json: cart
        end

        private

        def cart
            @cart ||= Cart.first
        end

        def discount
            @discount ||= cart.discounts.find(params[:id])
        end

        def prepare_cart
            unless Cart.any?
                Cart.create
            end
        end

        def discount_params
            params.permit(:id, :kind, :name, :price, :count, product_ids: [])
        end
    end
end
