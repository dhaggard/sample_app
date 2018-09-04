require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    # @not_activated = users(:not_activated)
  end


  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: '', password: '' } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "login with valid information" do
    get login_path
    post login_path, params: { session: { email: @user.email,password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_path
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end

  test "login with remembering" do
    # log_in_as sets remember_me to 1 by default
    log_in_as(@user)
    assert_equal cookies['remember_token'], assigns(:user).remember_token
  end

  test "login without remembering" do
    # login to set cookie
    log_in_as(@user, remember_me: '1')
    # login again to remove cookie
    log_in_as(@user, remember_me: '0')
    assert_empty cookies['remember_token']
  end

  test "default login when not using friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    delete logout_path
    assert_nil session[:forwarding_url]
    log_in_as(@user)
    assert_redirected_to @user
  end

  # test "login is as unactivated user" do
  # log_in_as(@not_activated)
  # assert_redirected_to root_path
  # assert_not flash.empty?
  # end
end
