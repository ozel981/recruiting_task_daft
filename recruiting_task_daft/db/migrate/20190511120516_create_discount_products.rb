class CreateDiscountProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :discount_products do |t|

      t.timestamps
    end
  end
end
