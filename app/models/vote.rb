class Vote < ApplicationRecord
  belongs_to :shop
  belongs_to :user
  belongs_to :menu
  has_one_attached :image
  validates :content, length: { maximum: 10 }
  validates :user_id, uniqueness: { scope: :menu, message: "同じメニューには既に投票済みです。" }
  
end
