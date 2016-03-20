class ClientAddZoneDefault < ActiveRecord::Migration
  def change
    change_column :clients, :zone_id, :integer, null: true
    change_column :clients, :cliente, :string, default: ''
    change_column :clients, :description, :text, null: true
    change_column :clients, :zona_postal, :integer, default: 0
    change_column :clients, :cliente_optional, :string, default: ''
    change_column :clients, :direction, :string, default: ''
    change_column :clients, :rif, :string, default: ''
    change_column :clients, :telefono, :string, default: ''
    change_column :clients, :saint_id, :string, default: ''
    change_column :clients, :status, :integer, default: 1
  end
end

