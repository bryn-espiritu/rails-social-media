class Group < ApplicationRecord
  has_many :group_member_ships, dependent: :destroy
  has_many :users, through: :group_member_ships

  mount_uploader :banner, ImageUploader

  validates :name, presence: true
end
