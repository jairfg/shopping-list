class StoreSection < ApplicationRecord
  validates :name, presence: true, length: { maximum: 64 }
  validates :name, format: { with: /\A[\p{L}\s]+\z/, message: "only letter and white space"  }
end
