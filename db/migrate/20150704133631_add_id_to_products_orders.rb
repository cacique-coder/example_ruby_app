class AddIdToProductsOrders < ActiveRecord::Migration
  def up
     execute <<-SQL
ALTER TABLE products_orders ADD COLUMN id BIGSERIAL PRIMARY KEY;
    SQL
  end
end
