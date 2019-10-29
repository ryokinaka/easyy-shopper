class Item < ApplicationRecord
  mount_uploader :image, ImageUploader
  
  belongs_to :user
  
  validates :image, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  validates :category, presence: true, length: { maximum: 20 }
  validates :price, presence: true, length: { maximum: 20 }
  validates :explanation, presence: true, length: { maximum: 255 }
end
