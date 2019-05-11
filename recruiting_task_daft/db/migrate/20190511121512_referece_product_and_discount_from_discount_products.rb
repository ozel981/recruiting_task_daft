class RefereceProductAndDiscountFromDiscountProducts < ActiveRecord::Migration[5.2]
  def change
    add_reference :discount_products, :product
    add_reference :discount_products, :discount
  end
end
