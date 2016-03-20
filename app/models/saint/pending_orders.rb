module Saint
  class PendingOrders
    def initialize
      @orders = Order.pending.map {|x| OrderConvert.new(x)}
    end

    def hash
      @orders.inject({}) do |hash, order|
        hash[order.id.to_s] = order.to_hash
        hash
      end
    end

    class OrderConvert
      attr_accessor :order

      delegate :client,:items, :user, :discount, :comentario, to: :order
      def initialize(order)
        @order = order
      end

      def id
        order.id
      end

      def products_array
        items.map { |x| { 'CODPROD': x.code.to_s, 'CANT': x.quantity.to_s   } }
      end

      def to_hash
        {
          "CODCLIE" => client.saint_id.to_s,
          "CODVEND" => user.saint_id.to_s,
          "descuento" => discount.to_s,
          "comentario" => comentario.to_s,
          "products" => products_array
        }
      end
    end
  end
end
