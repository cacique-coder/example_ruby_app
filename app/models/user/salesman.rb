class User::Salesman < User
  has_many :clients, class_name: '::Client', through: :zones
  has_many :zones, class_name: '::Zone', foreign_key: 'user_id'

  has_many :orders, foreign_key: 'user_id'

  def salesman?
    true
  end
end
