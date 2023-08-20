require 'rails_helper'

RSpec.describe Shop, type: :model do
  let(:category) { FactoryBot.create(:category) } # カテゴリーを作成

  it "有効な属性であること" do
    shop = FactoryBot.build(:shop, category: category)
    expect(shop).to be_valid
  end

  it "住所がない場合は無効であること" do
    shop = FactoryBot.build(:shop, category: category, address: nil)
    expect(shop).to_not be_valid
  end

  it "住所が重複した場合は無効であること" do
    FactoryBot.create(:shop, category: category, address: "123 Main St")
    shop = FactoryBot.build(:shop, category: category, address: "123 Main St")
    expect(shop).to_not be_valid
  end

  it "カテゴリーがない場合は無効であること" do
    shop = FactoryBot.build(:shop, category: nil)
    expect(shop).to_not be_valid
  end

  it "ショップがメニューを持つこと" do
    shop = FactoryBot.create(:shop, category: category)
    menu = FactoryBot.create(:menu, shop: shop)
    expect(shop.menus).to include(menu)
  end

  it "ショップが投票を持つこと" do
    shop = FactoryBot.create(:shop, category: category)
    user = FactoryBot.create(:user)
    vote = FactoryBot.create(:vote, shop: shop, user: user)
    expect(shop.votes).to include(vote)
  end

  it "ショップがユーザーを通じて投票を持つこと" do
    shop = FactoryBot.create(:shop, category: category)
    user = FactoryBot.create(:user)
    vote = FactoryBot.create(:vote, shop: shop, user: user)
    expect(shop.users).to include(user)
  end

  it "住所が変更された場合、緯度と経度が自動的に更新されること" do
    shop = FactoryBot.create(:shop, category: category, address: "123 Elm St")
    expect(shop.latitude).to_not be_nil
    expect(shop.longitude).to_not be_nil
  end

  # 他のバリデーションやテストケースも追加できます
end

