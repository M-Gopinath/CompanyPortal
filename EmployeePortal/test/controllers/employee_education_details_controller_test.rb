require 'test_helper'

class EmployeeEducationDetailsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get employee_education_details_index_url
    assert_response :success
  end

end
