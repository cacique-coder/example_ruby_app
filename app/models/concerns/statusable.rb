module Statusable

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def status
      {
        'Activo': 1,
        'Inactivo': 0
      }
    end
  end

  def block!
    self.status = 0
    self.save
  end

  def active!
    self.status = 1
    self.save
  end

  def change_status!
    active? ? block! : active!
  end

  def active?
    status.eql?(1)
  end

  def inactive?
    !active?
  end

end
