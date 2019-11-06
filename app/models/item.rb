class Item < ApplicationRecord
  mount_uploader :image, ImageUploader
  
  belongs_to :user
  
  validates :image, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  validates :category, presence: true, length: { maximum: 20 }
  validates :price, presence: true, length: { maximum: 20 }, numericality: { only_integer: true, greater_than: 0 }
  validates :explanation, presence: true, length: { maximum: 255 }
  
  has_many :wants, foreign_key: 'item_id', dependent: :destroy
  has_many :users, through: :wants
  
  has_many :buyers, foreign_key: 'item_id', dependent: :destroy
  has_many :users, through: :buyers
  
  enum category: { 'レディース': 0, 'メンズ': 1,  'ベビー・キッズ': 2, 'インテリア・住まい・小物': 3, '本・音楽・ゲーム': 4, 'おもちゃ・ホビー・グッズ': 5, 'コスメ・香水・美容': 6, '家電・スマホ・カメラ': 7, 'スポーツ・レジャー': 8, 'ハンドメイド': 9, 'チケット': 10, '自転車・オートバイ': 11, 'その他': 12 }
  
  scope :get_by_category, ->(category) {
    where(category: category)
  }
end
