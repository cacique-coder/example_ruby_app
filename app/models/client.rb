class Client < ActiveRecord::Base
  include Statusable

  belongs_to :zone

  scope :user_id_eq, ->(user_id) { joins(zone: :user).where('users.id = ?', user_id) }
  scope :actives, -> { where(status: 1) }

  validates_uniqueness_of :saint_id
  validates_presence_of :cliente, :rif, :saint_id
  delegate :user, to: :zone, allow_nil: true

  def salesman
    user || User::Nil.new
  end

  def name
    cliente
  end
  private

  def self.ransackable_scopes(auth_object = nil)
    %i(user_id_eq)
  end
end
