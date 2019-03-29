require 'test_helper'

class FinanceManagement::OfficeSalariesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get finance_management_office_salaries_index_url
    assert_response :success
  end

end
