require 'test_helper'

class ClientSocialNetworksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get client_social_networks_index_url
    assert_response :success
  end

end
