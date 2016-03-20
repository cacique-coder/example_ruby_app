class OrderDecorator < Draper::Decorator
  delegate_all

  decorates_association :user
  decorates_association :client
  decorates_association :items

  def review
    object.processed? ? 'Procesado' : 'Pendiente'
  end

  def review_class
   'order-not-process' unless object.review?
  end

  def date_created
    DateFormat.new(object.created_at).full_default
  end

  def date_updated
    DateFormat.new(object.updated_at).full_default
  end

  def discount
    h.number_to_percentage((object.discount * 100), precision: 0)
  end

  def subtotal
    h.number_money(object.subtotal)
  end

  def iva
    h.number_money(object.iva)
  end

  def total
    h.number_money(object.total)
  end
end
