class User < ApplicationRecord
  attr_accessor :old_password

  has_secure_password validations: false

  validate :password_presense
  validate :correct_old_password, on: :update, if: -> { password.present? }
  validates :password, confirmation: true, allow_blank: true,
    length: {minimum: 8, maximum: 50}

  validates :email, presence: true, uniqueness: true,'valid_email_2/email': true
  validate :password_complexity
  
  private

  def correct_old_password
    return if BCrypt::Password.new(password_digest_was).is_password?(old_password)

    errors.add :old_password, 'is incorrect'
  end

  def password_complexity
    return if password.blank? || password =~ /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,70}$/

    errors.add :password, 'complexity requirement not met. Length should be 8-70 characters and include: 1 uppercase, 1 lowercase, 1 digit and 1 special character'
  end

  def password_presense
    errors.add(:password, :blank) unless password_digest.present?
  end
end
