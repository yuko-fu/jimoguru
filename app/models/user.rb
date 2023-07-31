class User < ApplicationRecord
  has_many :votes, dependent: :destroy
  has_many :shops, through: :votes
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
