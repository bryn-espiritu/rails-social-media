class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  has_many :friend_requests, dependent: :destroy
  has_many :received_friend_requests, class_name: "FriendRequest", foreign_key: :friend_id, dependent: :destroy
  has_many :pending_friends, through: :friend_requests, source: :friend
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :group_member_ships, dependent: :destroy
  has_many :groups, through: :group_member_ships

  enum role: { normal: 0, moderator: 1, admin: 2 }

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :github, :google_oauth2]

  def self.create_from_provider_data(provider_data)
    where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do |user|
      user.email = provider_data.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def remove_friend(friend)
    friends.destroy(friend)
  end
end
