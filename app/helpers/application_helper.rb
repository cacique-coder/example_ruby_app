module ApplicationHelper
  def number_money(value)
    number_to_currency(value, unit: 'Bs. ', delimiter: '.', separator: ',')
  end
end
