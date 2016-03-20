class User::GuestDecorator < UserDecorator
  decorates User::Guest
  delegate_all

  def menu
    h.render partial: 'shared/users/menu_guest'
  end

  def to_s
    'invitado'
  end

end
