class RefernceCartFromItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :cart
  end
end
