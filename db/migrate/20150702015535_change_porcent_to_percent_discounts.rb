class ChangePorcentToPercentDiscounts < ActiveRecord::Migration
  def change
    rename_column :discounts, :porcent, :percent
  end
end
