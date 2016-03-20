class ZoneDecorator < Draper::Decorator
  delegate_all

  decorates_association :user
  decorates_association :clients

  def to_s
    object.name
  end

  def user_name
    object.user.name
  end

end
