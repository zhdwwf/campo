require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should create user" do
    assert_not_nil create(:user)
  end

  test "should save lower username" do
    assert_equal "lower", create(:user, username: 'LOWER').username_lower
  end

  test "should save lower email" do
    assert_equal "lower@example.com", create(:user, email: 'LOWER@example.com').email_lower
  end

  test "should have remember token" do
    user = create(:user)
    assert_not_nil user.remember_token
    assert_equal user, User.find_by_remember_token(user.remember_token)
    assert_equal nil, User.find_by_remember_token('invalidtoken')
  end

  test "should genrate password_reset_token" do
    user = create(:user)
    assert_nil user.password_reset_token
    user.generate_password_reset_token
    assert_not_nil user.password_reset_token
    assert_not_nil user.password_reset_token_created_at
  end
end
