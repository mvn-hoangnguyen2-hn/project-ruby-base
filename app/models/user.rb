class User < ApplicationRecord
  enum :role, { user: "user", admin: "admin" }, default: :user

  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true, length: { minimum: 6 }, on: :create

  def admin?
    role == "admin"
  end

  has_many :cars, dependent: :destroy
  accepts_nested_attributes_for :cars, allow_destroy: true

  validate :validate_car_limit

  private

  def validate_car_limit
    if cars.size > 2
      errors.add(:cars, "can have at most 2 vehicles")
    end
  end
end

