require 'rails_helper'

RSpec.describe "投票機能", type: :system do
  let!(:second_user) { FactoryBot.create(:second_user) }
  let!(:shop) { FactoryBot.create(:shop) } 
  

  describe "新規投票ページ" do
    context "ページの表示" do
      it "正しいページタイトルが表示されていること" do
        @shop = FactoryBot.create(:shop, prefecture: second_user.prefecture)
        visit new_user_session_path
        fill_in 'user_email', with: "second_user@example.com"
        fill_in 'user_password', with: "second_user"
        click_button "ログイン"
        visit new_vote_path(@shop)
        expect(page).to have_content("おすすめメニュー投票")
      end

      it "フォームが正しく表示されていること" do
        @shop = FactoryBot.create(:shop, prefecture: second_user.prefecture)
        visit new_user_session_path
        fill_in 'user_email', with: "second_user@example.com"
        fill_in 'user_password', with: "second_user"
        click_button "ログイン"
        visit new_vote_path(@shop)
        expect(page).to have_field("【投票メニュー名】")
        expect(page).to have_field("メニュー価格の価格など一言投稿")
        expect(page).to have_field("写真投稿")
        expect(page).to have_button("投 票")
      end
    end

    context "フォームの送信" do
      it "有効なデータでフォームが送信できること" do
        @shop = FactoryBot.create(:shop, prefecture: second_user.prefecture)
        visit new_user_session_path
        fill_in 'user_email', with: "second_user@example.com"
        fill_in 'user_password', with: "second_user"
        click_button "ログイン"
        visit new_vote_path(@shop)

        choose "sample menu" 
        fill_in "vote_content", with: "価格情報"
        click_button "投 票"
        
        expect(page).to have_content("投票が成功しました。")
      end
    end
  end

  # 他のテストケースも同様に記述
end
