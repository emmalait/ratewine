require 'test_helper'

class WineriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @winery = wineries(:one)
  end

  test "should get index" do
    get wineries_url
    assert_response :success
  end

  test "should get new" do
    get new_winery_url
    assert_response :success
  end

  test "should create winery" do
    assert_difference('Winery.count') do
      post wineries_url, params: { winery: { name: @winery.name, year: @winery.year } }
    end

    assert_redirected_to winery_url(Winery.last)
  end

  test "should show winery" do
    get winery_url(@winery)
    assert_response :success
  end

  test "should get edit" do
    get edit_winery_url(@winery)
    assert_response :success
  end

  test "should update winery" do
    patch winery_url(@winery), params: { winery: { name: @winery.name, year: @winery.year } }
    assert_redirected_to winery_url(@winery)
  end

  test "should destroy winery" do
    assert_difference('Winery.count', -1) do
      delete winery_url(@winery)
    end

    assert_redirected_to wineries_url
  end
end
