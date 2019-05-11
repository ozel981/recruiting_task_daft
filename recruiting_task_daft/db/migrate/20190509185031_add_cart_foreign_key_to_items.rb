class AddCartForeignKeyToItems < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :items, :carts
  end
end
