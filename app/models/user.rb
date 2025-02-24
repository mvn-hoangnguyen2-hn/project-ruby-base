class User < ApplicationRecord
  enum :role, { user: "user", admin: "admin" }, default: :user

  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true, length: { minimum: 6 }, on: :create

  def admin?
    role == "admin"
  end

  has_many :cars
end

