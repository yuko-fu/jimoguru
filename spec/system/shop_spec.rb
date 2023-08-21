require 'rails_helper'

RSpec.describe "Shops", type: :system do
  let!(:second_user) { FactoryBot.create(:second_user) }
  let!(:admin_user) { FactoryBot.create(:admin_user) }
  let!(:shop) { FactoryBot.create(:shop) }

  describe "お店新規登録" do
    it "お店を新規登録できること" do
      visit new_user_session_path
      fill_in 'user_email', with: "second_user@example.com"
      fill_in 'user_password', with: "second_user"
      click_button "ログイン"
      visit new_shop_path
      fill_in "shop_name", with: "新しいお店"
      select "東京都", from: "shop_prefecture"
      fill_in "shop_address", with: "東京都千代田区"
      select "カテゴリー名", from: "shop_category_id" 

      click_button "登録"

      expect(page).to have_content("東京都")
      expect(page).to have_content("東京都千代田区")
      expect(page).to have_content("カテゴリー名")
    end

    it "新しいお店を登録すると地図上にマーカーが増えること" do
      visit new_user_session_path
      fill_in 'user_email', with: "second_user@example.com"
      fill_in 'user_password', with: "second_user"
      click_button "ログイン"
      
      visit new_shop_path
      fill_in "shop_name", with: "新しいお店"
      select "東京都", from: "shop_prefecture"
      fill_in "shop_address", with: "東京都千代田区"
      select "カテゴリー名", from: "shop_category_id"
      
      click_button "登録"
      
      visit shops_path

    # 地図上のマーカーを取得
    markers = page.all("area")

    expect(markers.count).to eq(2)
    end
  end

  describe "お店一覧ページ" do
    it "お店の一覧が表示されること" do
      visit new_user_session_path
      fill_in 'user_email', with: "second_user@example.com"
      fill_in 'user_password', with: "second_user"
      click_button "ログイン"
      
      visit shops_path

      expect(page).to have_content("Example Shop")
      
    end
    it "お店を都道府県で検索できること" do
      @shop = FactoryBot.create(:second_shop, prefecture: second_user.prefecture)
      visit new_user_session_path
      fill_in 'user_email', with: "second_user@example.com"
      fill_in 'user_password', with: "second_user"
      click_button "ログイン"
      visit shops_path

      # 都道府県で検索
      select "青森県", from: "prefecture"
      click_button "検索"

      # 検索結果にお店が表示されていることを確認
      expect(page).to have_content("Example Shop")
    end
    it "お店をカテゴリーで検索できること" do
      @shop = FactoryBot.create(:second_shop, prefecture: second_user.prefecture)
      visit new_user_session_path
      fill_in 'user_email', with: "second_user@example.com"
      fill_in 'user_password', with: "second_user"
      click_button "ログイン"
      visit shops_path
      select "カテゴリー名", from: "category_id"

      click_button "検索"

      expect(page).to have_content("カテゴリー名")
    end
  end

  describe "お店編集" do
    let!(:shop) { FactoryBot.create(:shop, prefecture: admin_user.prefecture) } 
    let!(:category) { FactoryBot.create(:category) }
    it "お店の情報を編集できること" do
      @shop = FactoryBot.create(:shop, prefecture: admin_user.prefecture)
      visit new_user_session_path
      fill_in 'user_email', with: "admin@example.com"
      fill_in 'user_password', with: "admin_password"
      click_button "ログイン"
    
      visit shop_path(@shop)
      click_link "ショップ情報編集"
      fill_in "shop_name", with: "編集後のお店名"
      select "神奈川県", from: "shop_prefecture" 
      fill_in "shop_address", with: "神奈川県横浜市"
      select "ベーカリー", from: "shop_category_id" 

      click_button "登録"

      
      expect(page).to have_content("神奈川県")
      expect(page).to have_content("神奈川県横浜市")
      expect(page).to have_content("ベーカリー")
    end
  end

  
  describe "お店詳細ページ" do
    let!(:shop) { FactoryBot.create(:shop) } # テスト用のお店を作成

    it "お店の詳細情報が表示されること" do
      @shop = FactoryBot.create(:shop, prefecture: second_user.prefecture)

      visit new_user_session_path
      fill_in 'user_email', with: "second_user@example.com"
      fill_in 'user_password', with: "second_user"
      click_button "ログイン"

      visit shop_path(@shop)

      expect(page).to have_content("Example Shop")
     
    end
  end

  

  

end
