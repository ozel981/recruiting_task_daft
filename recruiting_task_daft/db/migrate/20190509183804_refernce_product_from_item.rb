class RefernceProductFromItem < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :product
  end
end
