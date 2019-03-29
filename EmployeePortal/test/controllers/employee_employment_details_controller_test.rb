require 'test_helper'

class EmployeeEmploymentDetailsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get employee_employment_details_index_url
    assert_response :success
  end

end
