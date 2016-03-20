class ClientDecorator < Draper::Decorator
  include StatusableDecorator
  delegate_all
  decorates_association :zone

  def to_s
    object.cliente
  end

  def salesman
    object.salesman.decorate
  end

end
