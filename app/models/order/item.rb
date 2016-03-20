class Order::Item < ActiveRecord::Base
  belongs_to :order
  belongs_to :product, foreign_key: 'item_code'
  self.table_name = 'products_orders'
  delegate :code, :trademark, :description, to: :product

  monetize :price_cents

  before_validation :save_price

  def save_price
    self.price_cents = product.price_cents
  end

  def eql_order?(item)
    code == item.code
  end

  def as_json(options={})
    super({methods:[:trademark, :description]}.merge(options))
    .merge({'price' => price.to_f})
  end
  def total
    quantity * price
  end

end
