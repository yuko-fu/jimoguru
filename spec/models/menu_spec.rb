require 'rails_helper'

RSpec.describe Menu, type: :model do
  let(:shop) { FactoryBot.create(:shop) } # ショップを事前に作成

  it "有効な属性であること" do
    menu = FactoryBot.build(:menu, shop: shop)
    expect(menu).to be_valid
  end

  it "名前がない場合は無効であること" do
    menu = FactoryBot.build(:menu, name: nil, shop: shop)
    expect(menu).to_not be_valid
  end

  it "同じショップ内で重複した名前は無効であること" do
    existing_menu = FactoryBot.create(:menu, name: "Example Menu", shop: shop)
    menu = FactoryBot.build(:menu, name: "Example Menu", shop: shop)
    expect(menu).to_not be_valid
  end

  it "異なるショップで同じ名前は有効であること" do
    shop1 = FactoryBot.create(:shop)
    shop2 = FactoryBot.create(:second_shop)
    menu1 = FactoryBot.create(:menu, name: "Example Menu", shop: shop1)
    menu2 = FactoryBot.build(:menu, name: "Example Menu", shop: shop2)
    expect(menu2).to be_valid
  end

  # 他のバリデーションやテストケースも追加できます
end
