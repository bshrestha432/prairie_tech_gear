# app/models/user.rb
class User < ApplicationRecord
  # Include default devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :orders, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :order_items, through: :orders

  # Enums for roles
  enum role: { customer: 'customer', admin: 'admin' }, _default: 'customer'

  # Validations
  validates :name, presence: true
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :role, presence: true

  # Callbacks
  before_validation :set_default_role, on: :create

  # Address attributes (you might want to move these to a separate Address model later)
  attribute :province, :string
  attribute :address, :string
  attribute :city, :string
  attribute :postal_code, :string

  # Instance methods
  def cart_items_count
    orders.where(status: 'cart').sum { |order| order.order_items.sum(:quantity) }
  end

  def active_cart
    orders.find_or_create_by(status: 'cart')
  end

  private

  def set_default_role
    self.role ||= :customer
  end
end