module Carts
    class ItemsController < ApplicationController
        before_action :prepare_cart

        def create
            item_with_same_product = Item.find_by(product_id: params[:product_id])
            if item_with_same_product
                prev_quantity = item_with_same_product.quantity
                if !params.has_key?(:quantity)
                    item_with_same_product.update!(quantity: 1+prev_quantity) 
                else
                    item_with_same_product.update!(quantity: params[:quantity].to_i+prev_quantity)
                end
            else
                 cart.items.create!(item_params)
            end
            
            render json: cart
        end

        def update
            item.update!(item_params)
            if !params.has_key?(:quantity)
                item.update!(quantity: 1)
            elsif params[:quantity].to_i < 1
                destroy
            end
            render json: cart
        end

        def destroy
            item.destroy!
        end

        private

        def cart
            @cart ||= Cart.first
        end

        def prepare_cart
            unless Cart.any?
                Cart.create
            end
        end

        def item
            @item ||= cart.items.find(params[:id])
        end

        def item_params
            params.permit(:id, :quantity, :product_id)
        end
    end
end
