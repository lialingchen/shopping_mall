class Cart
    attr_reader :items
    def initialize(items = [])
       @items = items 
    end
    
    def serialize
        a= @items.map { |item|
            {"product_id" => item.product_id, "quantity"=>item.quantity}
            
        }
        # a= [] 
        # @items.each do |item|
        #     a << {"product_id" => item.product_id, "quantity" => item.quantity}
        # end
  
        { "items" => a }
    end
    
    def self.from_hash(hash)
        if hash.nil? or hash["items"].nil?
        #   Cart.new
            new
        else
            new hash["items"].map{ |item|
                CartItem.new(item["product_id"], item["quantity"])
            }
            # a = []
            # hash["items"].each do |item|
            # a << CartItem.new(item["product_id"], item["quantity"])
            # end
            # Cart.new(a)
        end
    end
    
    def add_item(product_id)
        found_item = items.find{ |item| 
        item.product_id == product_id 
        }
        if found_item
            found_item.increment
        else
            @items << CartItem.new(product_id)
        end
    
    end
    
    def empty?
        @items.empty?
    end
    
    def total_price
        # total = 0
        # @items.each do |item|
        #   total += item.total_price 
        # end
        items.reduce(0) { |sum, item| sum + item.total_price }
    end
end

