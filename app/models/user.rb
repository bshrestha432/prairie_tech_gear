class User < ApplicationRecord
  # Devise modules (uncomment if using Devise)
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable

  # Associations
  has_many :orders, dependent: :destroy
  has_many :payments, through: :orders
  has_many :reviews, dependent: :destroy
  has_many :order_items, through: :orders

  # Validations
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }

  # Ransack configuration - Safe searchable attributes
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "id", "name", "updated_at"]
    # Never include password, reset_token, or other sensitive fields
  end

  # Ransack configuration - Safe searchable associations
  def self.ransackable_associations(auth_object = nil)
    ["orders", "order_items", "payments", "reviews"]
    # Only include associations that don't expose sensitive data
  end

  # Display method for ActiveAdmin
  def display_name
    "#{name} (#{email})"
  end
end