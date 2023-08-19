require 'rails_helper'

RSpec.describe Category, type: :model do
  it "有効な属性であること" do
    category = FactoryBot.build(:category)
    expect(category).to be_valid
  end

  it "名前がない場合は無効であること" do
    category = FactoryBot.build(:category, name: nil)
    expect(category).to_not be_valid
  end

end
