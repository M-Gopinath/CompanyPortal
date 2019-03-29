require 'test_helper'

class OfficeIncomesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get office_incomes_create_url
    assert_response :success
  end

end
