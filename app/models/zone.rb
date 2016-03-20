class Zone < ActiveRecord::Base
  belongs_to :user
  has_many :clients

  validates_presence_of :name
end
