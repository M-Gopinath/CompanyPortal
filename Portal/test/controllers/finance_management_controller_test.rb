require 'test_helper'

class FinanceManagementControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get finance_management_index_url
    assert_response :success
  end

end
