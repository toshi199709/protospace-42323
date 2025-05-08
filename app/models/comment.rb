class Comment < ApplicationRecord

  validates :text, presence: true
  validates :prototype, presence: true
  validates :user, presence: true

  belongs_to :user
  belongs_to :prototype
end