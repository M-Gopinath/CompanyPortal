require 'test_helper'

class ClientCompanyDetailsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get client_company_details_index_url
    assert_response :success
  end

end
