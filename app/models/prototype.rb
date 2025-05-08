class Prototype < ApplicationRecord
  validates :title, :catch_copy, :concept, :user, presence: true
  validate :image_attached

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :image

  private

  def image_attached
    errors.add(:image, "を添付してください") unless image.attached?
  end
end
