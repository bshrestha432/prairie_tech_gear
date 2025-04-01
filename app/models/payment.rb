class Payment < ApplicationRecord
  belongs_to :order

  def self.ransackable_attributes(auth_object = nil)
    ["amount", "created_at", "id", "order_id", "payment_method", "status", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["order"]
  end
end
