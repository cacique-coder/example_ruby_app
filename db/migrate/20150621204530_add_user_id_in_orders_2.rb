class AddUserIdInOrders2 < ActiveRecord::Migration
  def up
    Order.all.each do |order|
      user = User.find_by_login(order.login_user)
      order.user = user
      order.save
    end
    Zone.all.each do |zone|
      user = User.find_by_login(zone.login_user)
      zone.user = user
      zone.save
    end
  end
end
