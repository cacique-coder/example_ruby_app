class Order < ActiveRecord::Base
  has_many :items, class_name: 'Order::Item', dependent: :destroy

  belongs_to :user
  belongs_to :client

  default_scope -> { newest }
  scope :newest, -> { order(id: :desc) }
  scope :pending, -> { where(review: false)}
  scope :recently_created, -> { where("created_at > ?",Time.now - 30.minutes) }
  scope :query_mobile, -> { where("created_at > ?",Time.now - 3.month) }
  accepts_nested_attributes_for :items

  validates_presence_of :client
  validate :order_not_repeated, on: :create

  def self.status
    {
      'Pendiente' => false,
      'Procesada' => true
    }
  end

  def self.review_orders(order_hash)
    x = find(order_hash['order_id'].to_i)
    x.review!
  end

  def order_not_repeated
    Order.recently_created.each do |order|
      if has_same_items?(order)
        errors.add(:items, 'Los items se encuentra en otra orden')
      end
    end
  end

  def has_same_items?(order)
    items.size == order.items.size && items.all? do |current_item|
       order.items.any? {|compare_item|  current_item.eql_order?(current_item) }
     end
  end

  def iva
    @iva ||= (subtotal_products * IVA.val ).round(2)
  end

  def total
    subtotal + iva
  end

  def subtotal
    @subtotal ||= subtotal_products*(1 - discount)
  end

  def review!
    self.review = true
    self.save
  end

  def processed?
    review.eql?(1)
  end

  def pending?
    !processed?
  end

  def as_json(options={})
    super({
      methods: [:client_name],
      include: [
        items: {methods: [:trademark, :description]}
        ]
    }.merge(options))
  end

  def client_name
    client.try(:cliente)
  end

  private

  def subtotal_products
    items.map(&:total).sum
  end

end


