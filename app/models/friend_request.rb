class FriendRequest < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  validates :friend, uniqueness: { scope: :user }
  validate :not_self
  validate :not_friends
  validate :not_pending

  def accept
    transaction do
      user.friends << friend unless user.friends.exists?(id: friend.id)
      destroy!
    end
  end

  private

  def not_self
    errors.add(:friend, "cannot be yourself") if user == friend
  end

  def not_friends
    return unless user && friend

    errors.add(:friend, "is already added") if user.friends.exists?(id: friend.id)
  end

  def not_pending
    return unless user && friend

    if FriendRequest.exists?(user: friend, friend: user)
      errors.add(:friend, "has already sent you a request")
    end
  end
end
