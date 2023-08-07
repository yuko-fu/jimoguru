class Vote < ApplicationRecord
  belongs_to :shop
  belongs_to :user
  belongs_to :menu
  has_one_attached :image
  validates :content, length: { maximum: 10 }
  validate :user_and_shop_prefecture_match
  
  private

  def user_and_shop_prefecture_match
    if user.prefecture != shop.prefecture
      errors.add(:base, 'ユーザーの都道府県とお店の都道府県が一致していないため、投票できません。')
    end
  end
end
