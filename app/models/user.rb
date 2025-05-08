class User < ApplicationRecord
  # Deviseで使うモジュール
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 独自のバリデーション（emailとpassword以外）
  validates :name, presence: true
  validates :profile, presence: true
  validates :occupation, presence: true
  validates :position, presence: true

  has_many :prototypes
  has_many :comments
end
