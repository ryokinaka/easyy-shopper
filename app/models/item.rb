class Item < ApplicationRecord
  mount_uploader :image, ImageUploader
  
  belongs_to :user
  
  validates :image, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  validates :category, presence: true, length: { maximum: 20 }
  validates :price, presence: true, length: { maximum: 20 }
  validates :explanation, presence: true, length: { maximum: 255 }
  
  has_many :wants, foreign_key: 'item_id', dependent: :destroy
  has_many :users, through: :wants
  
  has_many :buyers, foreign_key: 'item_id'
  has_many :users, through: :buyers
end
