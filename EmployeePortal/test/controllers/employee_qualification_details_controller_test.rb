require 'test_helper'

class EmployeeQualificationDetailsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get employee_qualification_details_index_url
    assert_response :success
  end

end
