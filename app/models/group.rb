class Group < ApplicationRecord
  has_many :group_member_ships
  has_many :users, through: :group_member_ships

  mount_uploader :banner, ImageUploader

end
