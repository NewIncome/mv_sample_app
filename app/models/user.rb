class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token
  before_save { self.email = email.downcase }
  before_create :create_activation_digest

  validates :name, presence: true, length: { maximum: 35 }
  # () and {} not needed, but indeed an object is being passed.
  # adding custom short email Regexp
  # also we test for uniqueness and case insensitivity
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates(:email, presence: true, length: { maximum: 40 },
      format: { with: VALID_EMAIL_REGEX },
      uniqueness: { case_sensitive: false })
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 },
                      allow_nil: true   # this is to pass some tests
  # also this does not interfere with correct operation of having empty
  # passwords because the has_secure_password method activet.
  # So it's mainly used for <tests> and for <update/edit> purposes::to
  # update other fields.

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

  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)   # this rem_tok is a local variable, not the :rem_tok from line 2
    # now added a change for generic names
    digest = send("#{attribute}_digest")  # = self.send
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
    # remember_digest is the same as self.remember_digest
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  #Activates an account
  def activate
    # here we don't need to write user.update_... because of where we are
    # or used self.
    update_attribute(:activated, true)
    update_attribute(:activated_at, Time.zone.now)
  end

  # Sends activation email!!
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  private

  # Converts email to all lower-case
  def downcase_email
    self.email.downcase!
  end

  # Creates and assigns the activation token and digest
  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end
