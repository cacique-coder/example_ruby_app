class Order::ItemDecorator < Draper::Decorator
  delegate_all
  decorates_association :product

  def total
    h.number_money(object.total)
  end
end
