class Shop < ApplicationRecord
  belongs_to :category
  has_many :menus, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :users, through: :votes
end
