require 'rails_helper'

RSpec.describe "Categories", type: :system do
  let!(:admin_user) { FactoryBot.create(:admin_user) }

  describe "カテゴリー管理" do
    context "カテゴリー一覧ページ" do
      let!(:category) { FactoryBot.create(:category, name: "テストカテゴリー") }

      it "管理者ユーザーがカテゴリー一覧ページを表示できること" do
        visit new_user_session_path
        fill_in 'user_email', with: "admin@example.com"
        fill_in 'user_password', with: "admin_password"
        click_button "ログイン"
        visit categories_path
        expect(page).to have_content("テストカテゴリー")
      end
    end

    context "新しいカテゴリーの作成" do
      it "管理者ユーザーが新しいカテゴリーを作成できること" do
        visit new_user_session_path
        fill_in 'user_email', with: "admin@example.com"
        fill_in 'user_password', with: "admin_password"
        click_button "ログイン"
        visit new_category_path
        fill_in "category_name", with: "新しいカテゴリー"
        click_on "保存"
        
        expect(page).to have_content("新しいカテゴリー")
      end
    end

    context "カテゴリーの編集" do
      let(:category) { FactoryBot.create(:category, name: "編集前のカテゴリー") }

      it "管理者ユーザーがカテゴリーを編集できること" do
        visit new_user_session_path
        fill_in 'user_email', with: "admin@example.com"
        fill_in 'user_password', with: "admin_password"
        click_button "ログイン"
        visit edit_category_path(category)
        fill_in "category_name", with: "編集後のカテゴリー"
        click_on "保存"
        
        expect(page).to have_content("編集後のカテゴリー")
      end
    end
  end
end
