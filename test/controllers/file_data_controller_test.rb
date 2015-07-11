require 'test_helper'

class FileDataControllerTest < ActionController::TestCase
  test "should get add_file" do
    get :add_file
    assert_response :success
  end

end
