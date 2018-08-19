require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "layout_links" do
    get root_path
    assert_not is_logged_in?
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", signup_path
    assert_select "a[href=?]", login_path

    assert_select "title", full_title("Home")
    get about_path
    assert_select "title", full_title("About")
    get contact_path
    assert_select "title", full_title("Contact")
    get signup_path
    assert_select "title", full_title("Sign up")
    get login_path
    assert_select "title", full_title("Login")

    log_in_as(@user)
    assert is_logged_in?
    get root_path
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", signup_path, count: 0
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", users_path
    assert_select "a[href=?]", user_path(@user)
    assert_select "a[href=?]", edit_user_path(@user)
    get user_path(@user)
    assert_select "title", full_title("#{@user.name.capitalize}")
    get edit_user_path(@user)
    assert_select "title", full_title("Edit user")
    get users_path
    assert_select "title", full_title("All users")
  end
end
