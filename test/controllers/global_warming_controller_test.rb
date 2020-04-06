require 'test_helper'

class GlobalWarmingControllerTest < ActionDispatch::IntegrationTest
  test "should get diff" do
    get global_warming_diff_url
    assert_response :success
  end

end
