require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
    assert_no_difference "User.count" do
      post users_path, params: { user: { name: "",
                                         email: "user@invalid",
                                         password: "foo",
                                         password_confirmation: "bar" } }
    end
    # This checks that the server returned a 422 error code
    assert_response :unprocessable_entity

    # This checks that we are back on the signup page
    assert_template "users/new"

    # These verify your SCSS/HTML error styling is actually appearing
    assert_select "div#error_explanation"
    assert_select "div.field_with_errors"
  end
end
