class Discount < ActiveRecord::Base
  validates_presence_of :name, :day
end
