require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
                    password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be pressent" do
    @user.name = " "
    assert_not @user.valid?
  end

  test 'email should be present' do
    @user.email = " "
    assert @user.valid? == false
  end

  test 'name should be short' do
    @user.name = 'a' * 20
    assert_not @user.valid?
  end

  test 'email should be short' do
    @user.email = 'a' * 30 + '@example.com'
    assert_not @user.valid?
  end

  # testing some emails for validity
  test 'email validation should accept valid addresses' do
    valid_addresses = %w[user@example.com USER@foo.COM
        A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  # testing some emails for invalidity
  test 'email validation should reject invalid addresses' do
    invalid_addresses = %w[user@example,com user_at_foo.org
        user.name@example. foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be
          invalid"
    end
  end

  # testing uniqueness
  test 'email addresses should be unique and case insensitive' do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  # test for email downcasing before_save
  test 'email addresses should be saved as lower-case' do
    mixed_case_email = 'Foo@ExAMPle.CoM'
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  # tests for password minimum requirements
  test 'passwords should be present (nonblank)' do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test 'password should have a minimum length' do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
end
