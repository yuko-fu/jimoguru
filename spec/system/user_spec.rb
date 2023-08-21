require 'rails_helper'

RSpec.describe "Users", type: :system do
  let!(:admin_user) { FactoryBot.create(:admin_user, admin: true) }
  let!(:second_user) { FactoryBot.create(:second_user, admin: false) }
  let!(:shop) { FactoryBot.create(:shop) }

  describe "ユーザー新規登録" do
    context "正常なデータを入力した場合" do
      it "ユーザーが新規登録できること" do
        visit new_user_registration_path

        fill_in "user_name", with: "新規ユーザー"
        fill_in "user_email", with: "new_user@example.com"
        fill_in "user_password", with: "password123"
        fill_in "user_password_confirmation", with: "password123"

        click_button "アカウント登録"

        # ユーザー登録が成功したことを検証
        expect(page).to have_content("お店を探す")
      end
    end

    context "重複したメールアドレスを入力した場合" do
      it "ユーザーが新規登録できないこと" do
        # 重複したメールアドレスを持つユーザーを作成
        # /existing_user = FactoryBot.create(:user, email: "second_user@example.com")
        visit new_user_registration_path
        
        fill_in "user_name", with: "新規ユーザー"
        fill_in "user_email", with: "second_user@example.com" 
        fill_in "user_password", with: "password123"
        fill_in "user_password_confirmation", with: "password123"

        click_button "アカウント登録"

        # ユーザー登録が失敗し、エラーメッセージが表示されたことを検証
        expect(page).to have_content("Eメールはすでに存在します")
      end
    end
  end

  describe "ユーザー詳細表示" do
    it "ユーザーの詳細ページ(投票履歴のページ)に遷移されること" do
      visit new_user_session_path
      fill_in 'user_email', with: "second_user@example.com"
      fill_in 'user_password', with: "second_user"
      click_button "ログイン"
      visit user_path(second_user)
      
      expect(page).to have_content("投稿写真") 
      
    end
  end

  describe "ユーザー編集" do
    it "ユーザーがプロフィールを編集できること" do
      visit new_user_session_path
      fill_in 'user_email', with: "second_user@example.com"
      fill_in 'user_password', with: "second_user"
      click_button "ログイン"
      visit edit_user_registration_path(second_user)
      
    end
  end

  describe "ユーザーのバリデーション" do
    
    context "管理者ユーザーがログインしている場合" do
      it "ショップのインデックスページにカテゴリー一覧が表示されること" do
        visit new_user_session_path
        fill_in 'user_email', with: "admin@example.com"
        fill_in 'user_password', with: "admin_password"
        click_button "ログイン"
        visit shops_path(shop)
        expect(page).to have_content("カテゴリー一覧")
      end
  
      it "ショップの詳細ページにショップ情報編集が表示されること" do
        visit new_user_session_path
        fill_in 'user_email', with: "admin@example.com"
        fill_in 'user_password', with: "admin_password"
        click_button "ログイン"
        visit shop_path(shop)
        expect(page).to have_content("ショップ情報編集")
      end
    end
  
    context "一般ユーザーがログインしている場合" do
      
      it "ショップのインデックスページにカテゴリー一覧が表示されないこと" do
        visit new_user_session_path
        fill_in 'user_email', with: "second_user@example.com"
        fill_in 'user_password', with: "second_user"
        click_button "ログイン"
        visit shops_path(shop)
        expect(page).not_to have_content("カテゴリー一覧")
      end
  
      it "ショップの詳細ページにショップ情報編集が表示されないこと" do
        visit new_user_session_path
        fill_in 'user_email', with: "second_user@example.com"
        fill_in 'user_password', with: "second_user"
        click_button "ログイン"
        visit shop_path(shop)
        expect(page).not_to have_content("ショップ情報編集")
      end
      it "ユーザーと店舗の都道府県が一致しない場合、'投票する'ボタンが表示されないこと" do
        visit new_user_session_path
        fill_in 'user_email', with: "second_user@example.com"
        fill_in 'user_password', with: "second_user"
        click_button "ログイン"
        visit shop_path(shop) 
    
        expect(page).to_not have_button("投票する") # '投票する' ボタンが表示されないことを確認
      end
    end
  end
end
