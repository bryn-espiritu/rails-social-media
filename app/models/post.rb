class Post < ApplicationRecord
  belongs_to :user
  has_many :comments

  mount_uploader :image, ImageUploader
  enum tags: { public_tag: 'public_tag', private_tag: 'private_tag', friends_only: 'friends_only' }
end
