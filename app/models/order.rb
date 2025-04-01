class Order < ApplicationRecord
  belongs_to :user

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "status", "total", "updated_at", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["order_items", "user", "payments"]
  end
end
