require 'test_helper'

class EmployeeProfessionalDetailsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get employee_professional_details_index_url
    assert_response :success
  end

end
