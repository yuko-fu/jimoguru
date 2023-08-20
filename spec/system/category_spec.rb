require 'rails_helper'

RSpec.describe "Categories", type: :system do
  let!(:admin_user){FactoryBot.create(:admin_user)}
  before do
    visit new_user_session_path
    fill_in 'user[email]', with: "admin@example.com"
    fill_in 'user[password]', with: "admin_password"
    click_button "ログイン"
  end

  describe "カテゴリー一覧ページ" do
    let!(:category) { FactoryBot.create(:category, name: "テストカテゴリー") }

    it "管理者ユーザーがカテゴリー一覧ページを表示できること" do
      visit categories_path

      expect(page).to have_content("テストカテゴリー")
    end
  end

  describe "新しいカテゴリーの作成ページ" do
    it "管理者ユーザーが新しいカテゴリーを作成できること" do
      visit new_category_path

      fill_in "カテゴリー名", with: "新しいカテゴリー"
      click_on "保存"

      expect(page).to have_content("カテゴリーが作成されました")
      expect(page).to have_content("新しいカテゴリー")
    end
  end

  describe "カテゴリーの編集ページ" do
    let(:category) { FactoryBot.create(:category, name: "編集前のカテゴリー") }

    it "管理者ユーザーがカテゴリーを編集できること" do
      visit edit_category_path(category)

      fill_in "カテゴリー名", with: "編集後のカテゴリー"
      click_on "保存"

      expect(page).to have_content("カテゴリーが更新されました")
      expect(page).to have_content("編集後のカテゴリー")
    end
  end
end
