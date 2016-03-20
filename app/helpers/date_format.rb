class DateFormat
  def initialize(date)
    @date = date
  end

  def default
    @date.strftime(DateFormat.default)
  end

  def full_default
    @date.strftime(DateFormat.full_default)
  end

  def self.full_default
    '%d/%m/%Y %I:%M %p'
  end
  def self.default
    '%d/%m/%Y'
  end
end
