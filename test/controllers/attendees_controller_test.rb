require 'test_helper'

class AttendeesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get attendees_new_url
    assert_response :success
  end

  test "should get create" do
    get attendees_create_url
    assert_response :success
  end

  test "should get destroy" do
    get attendees_destroy_url
    assert_response :success
  end

end
