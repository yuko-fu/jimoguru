class Menu < ApplicationRecord
  belongs_to :shop
  has_many :votes, dependent: :destroy
  after_create :create_initial_vote
  validates :name, presence: true, uniqueness: { scope: :shop_id, case_sensitive: false }
  private

  def create_initial_vote
    vote = Vote.new
    vote.menu = self
    vote.save
  end

end
