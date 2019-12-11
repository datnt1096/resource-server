class User < ApplicationRecord
  enum role: %i(user admin)

  has_many :oauth_apps, dependent: :destroy
  has_many :authorizations, dependent: :destroy
  has_many :recharges, dependent: :destroy

  validates :name, presence: true

  mount_uploader :image, ImageUploader
end
