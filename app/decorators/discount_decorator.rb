class DiscountDecorator < Draper::Decorator
  delegate_all

  def percent
    h.number_to_percentage(object.percent*100, precision: 2, separator: ',')
  end
  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
