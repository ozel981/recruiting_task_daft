module Carts
    class TotalsController < ApplicationController
        def show
            respons = prepare_response

            render json: respons, status: 200
        end

        private

        def dfs(dproducts,discounts)
            pro_cop = []
            dproducts.each do |m|
                pro_cop += [m.dup]
            end
            maxdisc = 0
            thisdisc = 0
            disarray = []
            discounts.each_with_index do |discount,index|
                my_cost = 0
                discount[:product_ids].each do |id|
                    if dproducts.detect{|x| x[:id] == id}
                        if dproducts.detect{|x| x[:id] == id}[:quantity] > 0
                            my_cost += dproducts.detect{|x| x[:id] == id}[:price]
                            dproducts.detect{|x| x[:id] == id}[:quantity] -= 1
                        end
                    end
                end
                if my_cost > discount[:price]
                    thisdisc = my_cost - discount[:price]
                    nextdisc = dfs(dproducts,discounts)
                    dis = nextdisc[:maxdiscount] + thisdisc
                    if maxdisc < dis
                        maxdisc = dis
                        disarray = nextdisc[:discounts].dup
                        disarray.push(index)
                    end
                end
                dproducts = []
                pro_cop.each do |m|
                    dproducts += [m.dup]
                end
            end
            return { maxdiscount: maxdisc, discounts: disarray}
        end

        def get_products
            products = []
            cart.items.each do |item|
                products += [{id: item.product.id, quantity: item.quantity,price: item.product.price, name: item.product.name}]
            end
            return products
        end

        def get_discounts_and_kind
            discounts = []
            kinds = []
            cart.discounts.each do |discount|
                if discount.kind == "set"
                    discounts += [{product_ids: discount.product_ids, price: discount.price, name: discount.name}]
                    kinds += ["set"]
                else
                    discount.product_ids.each do |id|
                        kinds += ["extra"]
                        discounts += [{product_ids: Array.new(discount.count+1, id), price: discount.count * ProductsQuery.find_by_id(id).price,name: discount.name}]
                    end
                end
            end
            return [discounts,kinds]
        end

        def prepare_response
            products = get_products
            discounts = get_discounts_and_kind[0]
            best_discounts = dfs(products.dup,discounts.dup)[:discounts]

            return [{sets: sets(best_discounts), extras: extras(best_discounts),regural_products: regural_products(best_discounts),"regural price": regural_price}]
        end
        
        def regural_price
            products = get_products
            regural_price = 0
            products.each do |prod|
                regural_price += prod[:price] * prod[:quantity]
            end
            return regural_price
        end

        def regural_products(best_discounts)
            products = get_products
            discounts = get_discounts_and_kind[0]
            best_discounts.each do |it|
                discounts[it][:product_ids].each do |m|
                    if products.detect{|x| x[:id] == m}
                        products.detect{|x| x[:id] == m}[:quantity] -= 1   
                    end 
                end
            end
            regural_products = []
            products.each do |prod|
                (1..prod[:quantity]).each do |x|
                    prod.delete(:quantity)
                    regural_products += [prod]
                end
            end
            return regural_products
        end

        def sets(best_discounts)
            kind = get_discounts_and_kind[1]
            products = get_products
            discounts = get_discounts_and_kind[0]
            sets = []
            best_discounts.each do |it|
                if kind[it] == "set"
                    prod = []
                    discounts[it][:product_ids].each do |m|
                        if products.detect{|x| x[:id] == m}
                            products.detect{|x| x[:id] == m}[:quantity] -= 1   
                        end 
                        prod_data = ProductsQuery.find_by_id(m).attributes
                        prod_data.delete("created_at")
                        prod_data.delete("updated_at")
                        prod += [prod_data]     
                    end
                    sets += [{name: discounts[it][:name],products: prod,total: discounts[it][:price]}]
                end
            end
            return sets
        end

        def extras(best_discounts)
            kind = get_discounts_and_kind[1]
            products = get_products
            discounts = get_discounts_and_kind[0]
            extras = []
            best_discounts.each do |it|
                if kind[it] == "extra"
                    prod = []
                    discounts[it][:product_ids].each do |m|
                        if products.detect{|x| x[:id] == m}
                            products.detect{|x| x[:id] == m}[:quantity] -= 1   
                        end 
                        prod_data = ProductsQuery.find_by_id(m).attributes
                        prod_data.delete("created_at")
                        prod_data.delete("updated_at")
                        prod += [prod_data]     
                    end
                    extras += [{name: discounts[it][:name],products: prod,total: discounts[it][:price]}]
                end
            end
            return extras
        end

        def cart
            @cart ||= CartsQuery.get_cart
        end
    end
end
