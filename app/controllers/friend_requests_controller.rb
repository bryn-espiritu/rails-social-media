class FriendRequestsController < ApplicationController
  before_action :set_friend_request, except: [:index, :create]

  def index
    @incoming = FriendRequest.where(friend: current_user)
    @outgoing = current_user.friend_requests
    @strangers = User.where.not(id: current_user)
  end

  def create
    friend = User.find(params[:friend_id])
    @friend_request = current_user.friend_requests.new(friend: friend)
    if @friend_request.save
      render :index, status: :created, location: @friend_request
    else
      render json: @friend_request.errors, status: :unprocessable_entity
    end
  end

  def update
    @friend_request.accept
    if @friend_request.save
      redirect_to friend_requests_path, notice: "Friend Accepted"
    else
      redirect_to friend_requests_path, alert: "Error. Please Try again later"
    end
  end

  def destroy
    @friend_request.destroy
    if @friend_request.save
      redirect_to friend_requests_path, notice: "Successfully Cancelled"
    else
      redirect_to friend_requests_path, alert: "Error. Please Try again later"
    end
  end

  private

  def set_friend_request
    @friend_request = FriendRequest.find(params[:id])
  end

end
