require 'test_helper'

class ProjectListingsControllerTest < ActionDispatch::IntegrationTest
  test "should get active_projects" do
    get project_listings_active_projects_url
    assert_response :success
  end

  test "should get deactive_projects" do
    get project_listings_deactive_projects_url
    assert_response :success
  end

end
