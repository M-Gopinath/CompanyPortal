require 'test_helper'

class EmployeeListingsControllerTest < ActionDispatch::IntegrationTest
  test "should get active_listing" do
    get employee_listings_active_listing_url
    assert_response :success
  end

  test "should get deactive_listing" do
    get employee_listings_deactive_listing_url
    assert_response :success
  end

end
