class FriendRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_friend_request, only: [:update, :destroy]

  def index
    @incoming = FriendRequest.includes(:user).where(friend: current_user)
    @outgoing = current_user.friend_requests.includes(:friend)
    excluded_ids = current_user.friends.select(:id)
    @strangers = User.where.not(id: current_user.id)
                     .where.not(id: excluded_ids)
                     .where.not(id: @incoming.select(:user_id))
                     .where.not(id: @outgoing.select(:friend_id))
                     .order(:email)
  end

  def create
    friend = User.find(params[:friend_id])
    request = current_user.friend_requests.new(friend: friend)
    if request.save
      redirect_to friend_requests_path, notice: "Friend request sent."
    else
      redirect_to friend_requests_path, alert: request.errors.full_messages.to_sentence
    end
  end

  def update
    unless @friend_request.friend_id == current_user.id
      return redirect_to friend_requests_path, alert: "Only the recipient can accept this request."
    end

    @friend_request.accept
    redirect_to friend_requests_path, notice: "Friend accepted."
  rescue ActiveRecord::RecordInvalid
    redirect_to friend_requests_path, alert: "Could not accept the request."
  end

  def destroy
    unless [@friend_request.user_id, @friend_request.friend_id].include?(current_user.id)
      return redirect_to friend_requests_path, alert: "Not authorized."
    end

    @friend_request.destroy!
    redirect_to friend_requests_path, notice: "Friend request removed.", status: :see_other
  end

  private

  def set_friend_request
    @friend_request = FriendRequest.find(params[:id])
  end
end
