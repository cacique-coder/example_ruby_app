class UserDecorator < Draper::Decorator
  include StatusableDecorator
  delegate_all

  def to_s
    object.name
  end

  def menu
    h.render partial: 'shared/users/menu_superadmin'
  end

end
