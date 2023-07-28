require "application_system_test_case"

class VotePhotosTest < ApplicationSystemTestCase
  setup do
    @vote_photo = vote_photos(:one)
  end

  test "visiting the index" do
    visit vote_photos_url
    assert_selector "h1", text: "Vote Photos"
  end

  test "creating a Vote photo" do
    visit vote_photos_url
    click_on "New Vote Photo"

    fill_in "Content", with: @vote_photo.content
    fill_in "Image", with: @vote_photo.image
    fill_in "Vote", with: @vote_photo.vote_id
    click_on "Create Vote photo"

    assert_text "Vote photo was successfully created"
    click_on "Back"
  end

  test "updating a Vote photo" do
    visit vote_photos_url
    click_on "Edit", match: :first

    fill_in "Content", with: @vote_photo.content
    fill_in "Image", with: @vote_photo.image
    fill_in "Vote", with: @vote_photo.vote_id
    click_on "Update Vote photo"

    assert_text "Vote photo was successfully updated"
    click_on "Back"
  end

  test "destroying a Vote photo" do
    visit vote_photos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Vote photo was successfully destroyed"
  end
end
