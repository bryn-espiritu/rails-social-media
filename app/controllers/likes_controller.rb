class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    @post.likes.find_or_create_by!(user: current_user)
    redirect_back fallback_location: posts_path, notice: "Post liked.", status: :see_other
  end

  def destroy
    @post.likes.where(user: current_user).destroy_all
    redirect_back fallback_location: posts_path, notice: "Like removed.", status: :see_other
  end

  private

  def set_post
    @post = Post.visible_to(current_user).find(params[:post_id])
  end
end
