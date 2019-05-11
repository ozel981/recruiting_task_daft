class CreateDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :discounts do |t|
      t.string :kind, null: false
      t.string :name, index: { unique: true }
      t.float :price
      t.integer :count
      t.timestamps
    end
    add_reference :discounts, :cart
  end
end
