class AddUserIdInOrders < ActiveRecord::Migration
  def change
    add_column :orders, :user_id, :integer
    add_column :zones, :user_id, :integer
    add_index 'orders', ['user_id'], name: 'order_user_id', using: :btree
    add_index 'zones', ['user_id'], name: 'zone_user_id', using: :btree
  end
end
