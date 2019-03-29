require 'test_helper'

class EmployeePersonalDetailsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get employee_personal_details_index_url
    assert_response :success
  end

end
