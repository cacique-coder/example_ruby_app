class ParserProductsJob < ActiveJob::Base
  queue_as :default

  def perform(products)
    ParserProducts.new(products).process
  end
end
