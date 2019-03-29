require 'test_helper'

class EmployeeAgreementsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get employee_agreements_index_url
    assert_response :success
  end

end
