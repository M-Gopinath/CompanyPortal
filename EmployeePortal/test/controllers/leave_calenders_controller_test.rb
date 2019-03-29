require 'test_helper'

class LeaveCalendersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get leave_calenders_index_url
    assert_response :success
  end

end
