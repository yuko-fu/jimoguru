
require 'rails_helper'
RSpec.describe Vote, type: :model do
  describe "バリデーション" do
    it "contentが10文字以内の場合、有効であること" do
      vote = build(:vote, menu: "menu1", content: "")
      expect(vote).to be_valid
    end

    it "contentが11文字以上の場合、無効であること" do
      vote = Vote.new(:vote, menu: "menu1", content: "Too long text")
      expect(vote).to_not be_valid
      expect(vote.errors[:content]).to include("は10文字以内で入力してください")
    end

    it "同じユーザーが同じメニューに複数回投票すると無効であること" do
      existing_vote = create(:vote)
      vote = build(:vote, user: existing_vote.user, menu: existing_vote.menu)
      expect(vote).to_not be_valid
      expect(vote.errors[:user_id]).to include("同じメニューには既に投票済みです。")
    end

  end
end

