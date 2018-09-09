require "application_system_test_case"

class WineriesTest < ApplicationSystemTestCase
  setup do
    @winery = wineries(:one)
  end

  test "visiting the index" do
    visit wineries_url
    assert_selector "h1", text: "Wineries"
  end

  test "creating a Winery" do
    visit wineries_url
    click_on "New Winery"

    fill_in "Name", with: @winery.name
    fill_in "Year", with: @winery.year
    click_on "Create Winery"

    assert_text "Winery was successfully created"
    click_on "Back"
  end

  test "updating a Winery" do
    visit wineries_url
    click_on "Edit", match: :first

    fill_in "Name", with: @winery.name
    fill_in "Year", with: @winery.year
    click_on "Update Winery"

    assert_text "Winery was successfully updated"
    click_on "Back"
  end

  test "destroying a Winery" do
    visit wineries_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Winery was successfully destroyed"
  end
end
