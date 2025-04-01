require "test_helper"

class PeripheralsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get peripherals_index_url
    assert_response :success
  end

  test "should get show" do
    get peripherals_show_url
    assert_response :success
  end
end
