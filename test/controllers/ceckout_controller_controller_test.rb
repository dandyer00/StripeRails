require 'test_helper'

class CeckoutControllerControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get ceckout_controller_new_url
    assert_response :success
  end

end
