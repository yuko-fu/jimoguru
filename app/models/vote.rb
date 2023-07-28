class Vote < ApplicationRecord
  belongs_to :shop
  belongs_to :user
  belongs_to :menu
end
