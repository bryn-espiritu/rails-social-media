class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  mount_uploader :image, ImageUploader
  enum tags: { public_tag: 'public_tag', private_tag: 'private_tag', friends_only: 'friends_only' }

  validates :name, presence: true
  validates :content, presence: true
  validates :tags, presence: true

  scope :visible_to, ->(viewer) {
    where(tags: "public_tag")
      .or(where(user_id: viewer.id))
      .or(where(tags: "friends_only", user_id: viewer.friends.select(:id)))
  }

  scope :search_text, ->(query) {
    term = "%#{sanitize_sql_like(query.to_s.strip)}%"
    where("posts.name LIKE :term OR posts.content LIKE :term", term: term)
  }
end
