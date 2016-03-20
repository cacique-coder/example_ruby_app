class OrderRenameDatedCreatedAtcreatedAt < ActiveRecord::Migration
  def change
    rename_column :orders, :date_created, :created_at
    rename_column :orders, :date_updated, :updated_at
  end
end
