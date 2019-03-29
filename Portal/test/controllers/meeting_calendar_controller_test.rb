require 'test_helper'

class MeetingCalendarControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get meeting_calendar_index_url
    assert_response :success
  end

end
