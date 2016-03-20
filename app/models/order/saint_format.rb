class Order::SaintFormat
  def initalize

  end

  def pendings
    Order.pending
  end
end
