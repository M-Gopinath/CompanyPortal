require 'test_helper'

class ClientListingsControllerTest < ActionDispatch::IntegrationTest
  test "should get active_clients" do
    get client_listings_active_clients_url
    assert_response :success
  end

  test "should get deactive_clients" do
    get client_listings_deactive_clients_url
    assert_response :success
  end

end
