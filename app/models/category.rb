class Category < ApplicationRecord
  # ... any existing code ...

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "name", "updated_at"]
  end

  # ... any other code ...

  has_many :products, dependent: :destroy  # This line is crucial
  validates :name, presence: true, uniqueness: true
end