class Car < ApplicationRecord
  belongs_to :user

  enum :status, { pending: 0, approved: 1, rejected: 2 }, default: :pending

  validates :make, :model, :color, :license_plate, presence: true
end
