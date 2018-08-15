require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do  
    get signup_path
    assert_no_difference 'User.count' do
      assert_select '[action="/signup"]'
      post signup_path, params: {user: { name: "",
                                        email: "example@invalid",
                                        password:               "foo",
                                        password_confirmation:  "bar" } }
      end
      assert_template 'users/new'
      assert_select 'div#error_explanation'
      assert_select 'div.field_with_errors'
  end

  test "valid signup information" do
    get signup_path
    assert_difference "User.count", 1 do
      post signup_path, params: {user: { name: "Valid",
                                email: "example@valid.com",
                                password:               "correct",
                                password_confirmation:  "correct" } }
      end
      follow_redirect!
      assert_template 'users/show'
      assert_not flash.empty?
      assert is_logged_in?
  end
end
