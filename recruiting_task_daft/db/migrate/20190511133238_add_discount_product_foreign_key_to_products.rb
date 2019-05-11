class AddDiscountProductForeignKeyToProducts < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :discount_products, :products
  end
end
