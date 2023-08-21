require 'rails_helper'

RSpec.describe "Menus", type: :system do
  let!(:second_user) { FactoryBot.create(:second_user) }
  let!(:shop) { FactoryBot.create(:shop) } 
  

  describe "新しいメニューの登録" do
    it "メニューの登録に成功すること" do
      @shop = FactoryBot.create(:shop, prefecture: second_user.prefecture)
      visit new_user_session_path
      fill_in 'user_email', with: "second_user@example.com"
      fill_in 'user_password', with: "second_user"
      click_button "ログイン"
      visit shop_path(@shop)
      click_link "投票する"
      fill_in "name", with: "マルゲリータ"
      click_button "メニュー登録"

      expect(page).to have_content("マルゲリータ")
    end


    it "メニューの登録に失敗すること（重複したメニュー名）" do
      @shop = FactoryBot.create(:shop, prefecture: second_user.prefecture)
      FactoryBot.create(:menu, shop: @shop, name: "マルゲリータ")
      visit new_user_session_path
      fill_in 'user_email', with: "second_user@example.com"
      fill_in 'user_password', with: "second_user"
      click_button "ログイン"
      visit shop_path(@shop)
      click_link "投票する"
      expect(page).to have_content("新しいメニューを登録")
      fill_in "name", with: "マルゲリータ"
      click_button "メニュー登録"
      
      expect(Menu.count).to eq 1

    end
  end
end
