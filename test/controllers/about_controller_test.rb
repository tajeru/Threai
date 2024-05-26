require "test_helper"

class AboutControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get about_top_url
    assert_response :success
  end
end
