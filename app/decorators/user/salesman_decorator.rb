class User::SalesmanDecorator < UserDecorator
  decorates User::Salesman

  delegate_all

  def menu
    h.render partial: 'shared/users/menu_salesman'
  end

  def type
    'Vendedor'
  end
end
