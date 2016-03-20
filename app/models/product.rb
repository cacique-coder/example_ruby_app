class Product < ActiveRecord::Base

  self.primary_key = "code"
  validates_numericality_of :price, greater_than: 0
  validates_presence_of :code, :description
  validates :code, exclusion: {in: ["''",'""']}

  monetize :price_cents

  scope :available, -> { where( 'units > 0') }

  def self.trademark
    Product.uniq.select('trademark').order('trademark').pluck(:trademark)
  end

  def self.last_update
    order(updated_at: :desc).limit(1).pluck(:updated_at).first.to_i
  end

  def as_json(options={})
    super(options).merge('price' => self.price.to_f)
  end

end
