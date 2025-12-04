require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "User creation" do
    assert User.create(email: "test@example.com", password: "t"*6, password_confirmation: "t"*6)
  end
end
