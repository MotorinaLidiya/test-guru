class Badge < ApplicationRecord
  has_many :badge_to_users, dependent: :destroy
  has_many :users, through: :badge_to_users

  validates :title, presence: true, length: { maximum: 30 }, uniqueness: true
  validates :description, presence: true, length: { maximum: 60 }, uniqueness: true
  validates :condition, presence: true
  validates :image_url, presence: true
end
