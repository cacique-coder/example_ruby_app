class ParserProducts
  attr_accessor :file, :items

  def initialize(items)
    @items = items
  end

  def process
    save_and_load_products
  end
    
  def save_and_load_products
    items.map do |item|
      product = to_product(item)
      product.save
    end
  end

  private

  def to_product(item)
    attributes = item_to_hash(item)
    product =  Product.find_or_initialize_by(code: attributes[:code])
    product.assign_attributes(attributes)
    product
  end

  def item_to_hash(item)
    to_number(item[4])
    to_number(item[5])
    {
      code: item[0],
      description: item[1],
      trademark: item[2],
      price_cents:  item[4].to_f * 100,
      units: item[5].to_i
    }
  end

  def to_number(string_number)
    string_number.gsub!("\r",'')
    string_number.gsub!("\n",'')
    string_number.gsub!('.','')
    string_number.gsub!(',','.')
  end
end
