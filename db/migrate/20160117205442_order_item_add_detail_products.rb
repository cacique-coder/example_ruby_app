class OrderItemAddDetailProducts < ActiveRecord::Migration
  def up
    change_column :products, :price, :float, null: true
    add_monetize :products, :price
    add_monetize :products_orders, :price
  end

  def down
    remove_monetize :products, :price
    remove_monetize :products_orders, :price
  end
end
