class Feedback < ApplicationRecord
  belongs_to :test

  validates :message, presence: true
  validates :name, presence: true
  validates :author_email, presence: true
end
