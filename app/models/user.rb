class User < ActiveRecord::Base

  MAX_NAME_LENGTH = 255

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  # Soft delete - uses deleted_at field
  acts_as_paranoid

  enum role: {admin: 0, member: 1}

  # In order to override the devise validations, I have to remove the validatable module
  # and re-implement it with some changes
  validates :email, presence: true
  validates :email, format: {with: Devise.email_regexp, allow_blank: true}, if: :email_changed?
  validates :email, uniqueness: {scope: :deleted_at}, unless: :deleted?
  validates :password, presence: true, confirmation: true, on: :create
  validates :password, length: {within: Devise.password_length, allow_blank: true}

  # Non-devise validations
  validates :given_names, :family_name, length: {maximum: MAX_NAME_LENGTH}, presence: true
  validates :role, presence: true

  def full_name
    [given_names, family_name].compact.join(" ")
  end

  def to_s
    email
  end

end
