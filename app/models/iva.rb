class IVA < ActiveRecord::Base
  self.table_name = "IVA"

  def self.val
    first.percent
  end
end

