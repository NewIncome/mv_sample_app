class User < ApplicationRecord
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 19 }
  # () and {} not needed, but indeed an object is being passed.
  # adding custom short email Regexp
  # also we test for uniqueness and case insensitivity
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates(:email, presence: true, length: { maximum: 40 },
      format: { with: VALID_EMAIL_REGEX },
      uniqueness: { case_sensitive: false })
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

   # Returns the hash digest of the given string. We'll use it for
   # testing purposes, this is code 'bcryp' uses.
   def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
