require 'test_helper'

class YearlyHolidayCalendarControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get yearly_holiday_calendar_index_url
    assert_response :success
  end

end
