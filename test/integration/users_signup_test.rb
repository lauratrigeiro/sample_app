require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "invalid signup information" do
  	get signup_path
  	assert_no_difference 'User.count' do
  		post users_path, user: { name: "",
  								 email: "user@invalid",
  								 password: "foo",
  								 password_confirmation: "bar" }
  	end
  	assert_template 'users/new'
  	assert_select 'div#error_explanation'
  	assert_select 'div.alert' #, "The form contains 4 errors."
  #	assert_select 'li', "Name can&#39;t be blank"
  #	assert_select 'li', "Email is invalid"
  #	assert_select 'li', "Password confirmation doesn&#39;t match Password"
  #	assert_select 'li', "Password is too short (minimum is 6 characters)"
  	assert_select 'div.field_with_errors'
  end

  test "valid signup information" do
  	get signup_path
  	name = "Example User"
  	email = "user@example.com"
  	password = "password"
  	assert_difference 'User.count', 1 do
  		post_via_redirect users_path, user: { name: name,
  											  email: email,
  											  password: password,
  											  password_confirmation: password }
  	end
  	assert_template 'users/show'
  	assert is_logged_in?
  	assert_not flash.nil?
  end
end
