require 'test_helper'

class WineClubsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @wine_club = wine_clubs(:one)
  end

  test "should get index" do
    get wine_clubs_url
    assert_response :success
  end

  test "should get new" do
    get new_wine_club_url
    assert_response :success
  end

  test "should create wine_club" do
    assert_difference('WineClub.count') do
      post wine_clubs_url, params: { wine_club: { city: @wine_club.city, founded: @wine_club.founded, name: @wine_club.name } }
    end

    assert_redirected_to wine_club_url(WineClub.last)
  end

  test "should show wine_club" do
    get wine_club_url(@wine_club)
    assert_response :success
  end

  test "should get edit" do
    get edit_wine_club_url(@wine_club)
    assert_response :success
  end

  test "should update wine_club" do
    patch wine_club_url(@wine_club), params: { wine_club: { city: @wine_club.city, founded: @wine_club.founded, name: @wine_club.name } }
    assert_redirected_to wine_club_url(@wine_club)
  end

  test "should destroy wine_club" do
    assert_difference('WineClub.count', -1) do
      delete wine_club_url(@wine_club)
    end

    assert_redirected_to wine_clubs_url
  end
end
