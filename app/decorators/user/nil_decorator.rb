class User::NilDecorator < UserDecorator
  decorates User::Nil
  delegate_all

  def to_s
    'No asignado'
  end

end
