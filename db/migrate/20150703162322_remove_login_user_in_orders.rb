class RemoveLoginUserInOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :login_user
  end

end
