require 'rails_helper'

RSpec.describe Vote, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:shop) { FactoryBot.create(:shop) }
  let(:menu) { FactoryBot.create(:menu) }

  describe 'バリデーション' do
    it 'contentが10文字以内であること' do
      vote = FactoryBot.build(:vote, user: user, shop: shop, menu: menu, content: 'Short')
      expect(vote).to be_valid

      vote.content = 'ThisIsTooLong'
      expect(vote).not_to be_valid
    end

    it '同じユーザーが同じメニューに複数回投票できないこと' do
      FactoryBot.create(:vote, user: user, shop: shop, menu: menu)
      vote = FactoryBot.build(:vote, user: user, shop: shop, menu: menu)
      expect(vote).not_to be_valid
    end
  end
end


