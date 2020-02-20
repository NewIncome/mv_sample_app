require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end
  # # With the following test we will check:
  # 1.-Visit the login path.
  # 2.-Verify that the new sessions form renders properly.
  # 3.-Post to the sessions path with an invalid params hash.
  # 4.-Verify that the new sessions form gets re-rendered and that a flash message appears.
  # 5.-Visit another page (such as the Home page).
  # 6.-Verify that the flash message doesn’t appear on the new page.
  test 'login with invalid information' do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: '', password: '' } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test 'login with valid information followed by logout' do
    get login_path
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @user   # to check the right redirect target
    follow_redirect!             # to actually visit the target page
    assert_select "a[href=?]", login_path, count: 0  # verifies the
    # login link disappears by verifying there are 0 login path links.
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)

    # no to verify the correct logout and:
    # correct redirect to root,
    # correct login link show,
    # correct NOT show of logout and profile links.
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end  
end
