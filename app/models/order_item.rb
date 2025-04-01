class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  # If you don't have unit_price column but need it
  def unit_price
    # Either use an existing price field or calculate it
    self[:unit_price] || price || product.price
  end

 # Ransack configuration
 def self.ransackable_attributes(auth_object = nil)
  ["created_at", "id", "order_id", "price", "product_id", "quantity", "unit_price", "updated_at"]
end

def self.ransackable_associations(auth_object = nil)
  ["order", "product"]
end
end