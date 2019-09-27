require 'test_helper'

class AppointmentControllerTest < ActionDispatch::IntegrationTest
  test "should get index," do
    get appointment_index,_url
    assert_response :success
  end

  test "should get show" do
    get appointment_show_url
    assert_response :success
  end

end
