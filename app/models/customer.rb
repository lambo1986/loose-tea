class Customer < ApplicationRecord
  has_many :subscriptions

  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :address, presence: true
end
