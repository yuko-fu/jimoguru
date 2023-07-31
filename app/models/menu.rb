class Menu < ApplicationRecord
  belongs_to :shop
  has_many :votes, dependent: :destroy
end
