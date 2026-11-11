class FriendsController < ApplicationController
  before_action :authenticate_user!

  def index
    @friends = current_user.friends.order(:email)
  end

  def destroy
    friend = current_user.friends.find(params[:id])
    current_user.remove_friend(friend)
    redirect_to friends_path, notice: "Friend removed.", status: :see_other
  end
end
