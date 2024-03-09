class Subscription < ApplicationRecord
  belongs_to :customer
  has_many :subscription_teas
  has_many :teas, through: :subscription_teas

  validates :price, presence: true
  validates :status, presence: true
  validates :title, presence: true
  validates :frequency, presence: true
end
