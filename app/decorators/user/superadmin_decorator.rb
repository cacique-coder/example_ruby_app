class User::SuperadminDecorator < UserDecorator
  decorates User::Superadmin

  delegate_all

  def menu
    h.render partial: 'shared/users/menu_superadmin'
  end

  def type
    'Supervisor'
  end
end
