require "application_system_test_case"

class WineClubsTest < ApplicationSystemTestCase
  setup do
    @wine_club = wine_clubs(:one)
  end

  test "visiting the index" do
    visit wine_clubs_url
    assert_selector "h1", text: "Wine Clubs"
  end

  test "creating a Wine club" do
    visit wine_clubs_url
    click_on "New Wine Club"

    fill_in "City", with: @wine_club.city
    fill_in "Founded", with: @wine_club.founded
    fill_in "Name", with: @wine_club.name
    click_on "Create Wine club"

    assert_text "Wine club was successfully created"
    click_on "Back"
  end

  test "updating a Wine club" do
    visit wine_clubs_url
    click_on "Edit", match: :first

    fill_in "City", with: @wine_club.city
    fill_in "Founded", with: @wine_club.founded
    fill_in "Name", with: @wine_club.name
    click_on "Update Wine club"

    assert_text "Wine club was successfully updated"
    click_on "Back"
  end

  test "destroying a Wine club" do
    visit wine_clubs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Wine club was successfully destroyed"
  end
end
