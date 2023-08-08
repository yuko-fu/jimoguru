class Menu < ApplicationRecord
  belongs_to :shop
  has_many :votes, dependent: :destroy
  validates :name, presence: true, uniqueness: { scope: :shop_id, case_sensitive: false }
  
end
