class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true, length: { maximum: 40 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :address, length: { maximum: 60 }
  has_secure_password
  
  has_many :items
  
  has_many :wants
  has_many :wantings, through: :wants, source: :item
  
  has_many :buyers
  has_many :buyed_items, through: :buyers, source: :item
  
  def like(item)
    wants.find_or_create_by(item_id: item.id)
  end
  
  def unlike(item)
    want = wants.find_by(item_id: item.id)
    want.destroy if want
  end
  
  def wantings?(item)
    self.wantings.include?(item)
  end
  
  def buyed_item?(item)
    self.buyed_items.include?(item)
  end
end