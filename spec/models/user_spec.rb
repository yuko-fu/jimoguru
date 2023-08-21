# spec/models/user_spec.rb

require 'rails_helper'

RSpec.describe User, type: :model do
  it "一般ユーザーは正しく生成されること" do
    user = FactoryBot.create(:user)
    expect(user).to be_valid
  end

  it "ゲストユーザーは正しく生成されること" do
    guest_user = FactoryBot.create(:guest_user)
    expect(guest_user).to be_valid
  end

  it "ゲストユーザーかどうかを判定すること" do
    user = FactoryBot.create(:user)
    guest_user = FactoryBot.create(:guest_user)
    
    expect(user.guest?).to be_falsey
    expect(guest_user.guest?).to be_truthy
  end

  it "無効な認証を許可しないこと" do
    valid_user = FactoryBot.create(:admin_user, is_valid: false)
    invalid_user = FactoryBot.create(:user, is_valid: true)
    
    expect(valid_user.valid_for_authentication?).to be_truthy
    expect(invalid_user.valid_for_authentication?).to be_falsey
  end

  it "名前が存在しない場合はバリデーションエラーになること" do
    user = FactoryBot.build(:user, name: nil)
    expect(user).not_to be_valid
  end

  it "名前が30文字以上の場合はバリデーションエラーになること" do
    long_name = "a" * 31
    user = FactoryBot.build(:user, name: long_name)
    expect(user).not_to be_valid
  end

  it "メールアドレスが存在しない場合はバリデーションエラーになること" do
    user = FactoryBot.build(:user, email: nil)
    expect(user).not_to be_valid
  end

  it "メールアドレスが重複する場合はバリデーションエラーになること" do
    user1 = FactoryBot.create(:user, email: "duplicate@example.com")
    user2 = FactoryBot.build(:user, email: "duplicate@example.com")
    expect(user2).not_to be_valid
  end

  it "パスワードが存在しない場合はバリデーションエラーになること" do
    user = FactoryBot.build(:user, password: nil)
    expect(user).not_to be_valid
  end

  it "パスワードが6文字未満の場合はバリデーションエラーになること" do
    user = FactoryBot.build(:user, password: "short")
    expect(user).not_to be_valid
  end

  it '都道府県が存在しない場合はバリデーションエラーにならないこと' do
    user = FactoryBot.build(:user, prefecture: nil)  
    expect(user).to be_valid
  end
end
