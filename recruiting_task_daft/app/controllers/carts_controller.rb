class CartsController < ApplicationController
    before_action :prepare_cart

    def show
        render json: cart
    end

    private

    def prepare_cart
        unless Cart.any?
            Cart.create
        end
    end

    def cart
        @cart ||= Cart.first
    end
end
