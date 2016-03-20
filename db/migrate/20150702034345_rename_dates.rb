class RenameDates < ActiveRecord::Migration
  def change
    add_column :products, :created_at, :datetime
    rename_column :products, :date_updated_, :updated_at
  end
end
