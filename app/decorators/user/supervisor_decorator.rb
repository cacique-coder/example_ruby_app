class User::SupervisorDecorator < UserDecorator
  delegate_all

  def menu
    h.render partial: 'shared/users/menu_supervisor'
  end

  def type
    'Supervisor'
  end
end
