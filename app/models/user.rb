class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 19 }
  # () and {} not needed, but indeed an object is being passed.
  # adding custom short email Regexp
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates(:email, presence: true, length: { maximum: 19 },
      format: { with: VALID_EMAIL_REGEX })
end
