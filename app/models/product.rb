class Product < ApplicationRecord
  belongs_to :store_section, required: true

  validates :name, :purchase_date, :quantity, presence: true
  validates :name, length: { maximum: 128 }, format: { with: /\A[^%$&@+|]{1,128}\z/ }
  validates :store_name, length: { maximum: 64 }, format: { with: /\A[\w\s]+\z/, allow_blank: true }
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
  scope :pending_purchase, -> { where(purchased: false).order(purchase_date: :asc) }

  def self.hash_date_products
    pending_purchase.group_by{ |p| p.purchase_date }
  end

  def self.pending_purchase?(purchase_date)
    pending_purchase.exists?(purchase_date:)
  end
end
