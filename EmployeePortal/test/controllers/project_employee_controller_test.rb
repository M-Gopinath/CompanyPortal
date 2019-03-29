require 'test_helper'

class ProjectEmployeeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get project_employee_index_url
    assert_response :success
  end

end
