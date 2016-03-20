class User::Guest
  include Draper::Decoratable
  def guest?
    true
  end
end
