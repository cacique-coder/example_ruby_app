class User::AdministrationDecorator < UserDecorator
  delegate_all

  def menu
    h.render partial: 'shared/users/menu_superadmin'
  end

  def type
    'Administracion'
  end
end
