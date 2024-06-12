require "test_helper"

class RevelumControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get revelum_index_url
    assert_response :success
  end
end
