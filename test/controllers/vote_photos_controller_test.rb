require "test_helper"

class VotePhotosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @vote_photo = vote_photos(:one)
  end

  test "should get index" do
    get vote_photos_url
    assert_response :success
  end

  test "should get new" do
    get new_vote_photo_url
    assert_response :success
  end

  test "should create vote_photo" do
    assert_difference('VotePhoto.count') do
      post vote_photos_url, params: { vote_photo: { content: @vote_photo.content, image: @vote_photo.image, vote_id: @vote_photo.vote_id } }
    end

    assert_redirected_to vote_photo_url(VotePhoto.last)
  end

  test "should show vote_photo" do
    get vote_photo_url(@vote_photo)
    assert_response :success
  end

  test "should get edit" do
    get edit_vote_photo_url(@vote_photo)
    assert_response :success
  end

  test "should update vote_photo" do
    patch vote_photo_url(@vote_photo), params: { vote_photo: { content: @vote_photo.content, image: @vote_photo.image, vote_id: @vote_photo.vote_id } }
    assert_redirected_to vote_photo_url(@vote_photo)
  end

  test "should destroy vote_photo" do
    assert_difference('VotePhoto.count', -1) do
      delete vote_photo_url(@vote_photo)
    end

    assert_redirected_to vote_photos_url
  end
end
