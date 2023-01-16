class FriendsController < ApplicationController
  before_action :set_friend, only: :destroy

  def index
    @friends = current_user.friends

  end

  def destroy
    @friend = current_user.remove_friend(@friend)
    if @friend.save
    redirect_to friends_path, notice: "Successfully Removed"
    else
      redirect_to friends_path, alert: "Error. Please Try again later"
      end
  end

  private

  def set_friend
    @friend = current_user.friends.find(params[:id] || params[:friend_id])
  end
end
