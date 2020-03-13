require 'test_helper'

class UserEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)  # users set in the fixtures file
    @other_user = users(:archer)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name:  "",
                                              email: "foo@invalid",
                                              password:              "foo",
                                              password_confirmation: "bar" } }

    assert_template 'users/edit'
    
    assert_select 'div.alert', 'The form contains 4 errors.'
  end

  test "successful edit with friendly forwarding" do
    # log_in_as(@user)
    # get edit_user_path(@user)
    # assert_template 'users/edit'
    # commented because now we'll test for Friendly Forwarding
    p "THIS IS THE USER NAME: #{@user.name}"
    p "THIS IS THE USER ID: #{@user.id}"
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user) # Here we are testing that we
    # are being "friendly" forwarded to the edit_user which is the place we
    # wanted to go before being sent to the login, instead of being redirected
    # to the user/show like is coded in the sessions#create.

    name  = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), params: { user: { name:  name,
                                              email: email,
                                              password:              "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email
  end
end
