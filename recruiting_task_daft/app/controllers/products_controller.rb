
    class ProductsController < ApplicationController
        def index
            render json: ProductsQuery.all
        end
    end

