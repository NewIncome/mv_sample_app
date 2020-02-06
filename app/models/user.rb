class User < ApplicationRecord
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 19 }
  # () and {} not needed, but indeed an object is being passed.
  # adding custom short email Regexp
  # also we test for uniqueness and case insensitivity
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates(:email, presence: true, length: { maximum: 19 },
      format: { with: VALID_EMAIL_REGEX },
      uniqueness: { case_sensitive: false })
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
end
