require 'test_helper'

class UsersNotActivatedTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:not_activated)
  end

  # test "redirect when user not activated" do
  #   log_in_as @user
  # end
end
