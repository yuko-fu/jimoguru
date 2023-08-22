require "application_system_test_case"

class ShopsTest < ApplicationSystemTestCase
  setup do
    @shop = shops(:one)
  end

  test "visiting the index" do
    visit shops_url
    assert_selector "h1", text: "Shops"
  end

  test "creating a Shop" do
    visit shops_url
    click_on "New Shop"

    fill_in "Address", with: @shop.address
    fill_in "Category", with: @shop.category_id
    fill_in "Latitude", with: @shop.latitude
    fill_in "Longitude", with: @shop.longitude
    fill_in "Name", with: @shop.name
    fill_in "Prefecture", with: @shop.prefecture
    click_on "Create Shop"

    assert_text "お店の新規登録できました"
    click_on "Back"
  end

  test "updating a Shop" do
    visit shops_url
    click_on "Edit", match: :first

    fill_in "Address", with: @shop.address
    fill_in "Category", with: @shop.category_id
    fill_in "Latitude", with: @shop.latitude
    fill_in "Longitude", with: @shop.longitude
    fill_in "Name", with: @shop.name
    fill_in "Prefecture", with: @shop.prefecture
    click_on "Update Shop"

    assert_text "Shop was successfully updated"
    click_on "Back"
  end

  test "destroying a Shop" do
    visit shops_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Shop was successfully destroyed"
  end
end
