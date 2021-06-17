require "test_helper"

class SignupUserTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "Should signup user" do
    
    get signup_path
    # assert_template 'users/new'
    assert_response :success
    assert_difference 'User.count', 1 do
      post users_path, params: {user: {username: "test2", 
        email: "test2@gmail.com", password: "password2"}}
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
  end
end
