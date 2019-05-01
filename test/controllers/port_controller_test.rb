require 'test_helper'

class PortControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get port_index_url
    assert_response :success
  end

end
