require "test_helper"

class QuestionControllerTest < ActionDispatch::IntegrationTest
  test "should get ask" do
    get question_ask_url
    assert_response :success
  end
end
