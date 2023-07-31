class Vote < ApplicationRecord
  belongs_to :shop
  belongs_to :user
  belongs_to :menu
  has_one_attached :photo 
end
