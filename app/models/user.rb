class User < ApplicationRecord
  attr_accessor :remember_token
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

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
    #self.update(name: "Javier")
  end

  # Returns treu if the given token matches the digest.
  def authenticated?(remember_token)   # this rem_tok is a local variable, not the :rem_tok from line 2
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
    # remember_digest is the same as self.remember_digest
  end
end
