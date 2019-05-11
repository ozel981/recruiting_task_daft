class AddProductsForeignKeyToItems < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :items, :products
  end
end
