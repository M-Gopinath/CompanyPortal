require 'test_helper'

class EarningsControllerTest < ActionDispatch::IntegrationTest
  test "should get payslip" do
    get earnings_payslip_url
    assert_response :success
  end

end
