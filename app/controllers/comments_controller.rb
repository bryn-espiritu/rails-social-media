class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :authorize_comment_owner!, only: [:edit, :update, :destroy]

  def index
    @comments = @post.comments.includes(:user).order(created_at: :asc)
  end

  def new
    @comment = @post.comments.build
  end

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to post_comments_path(@post), notice: "Comment added."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      redirect_to post_comments_path(@post), notice: "Comment updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy!
    redirect_to post_comments_path(@post), notice: "Comment deleted.", status: :see_other
  end

  private

  def set_post
    @post = Post.visible_to(current_user).find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def authorize_comment_owner!
    return if @comment.user_id == current_user.id

    redirect_to post_comments_path(@post), alert: "You can only change your own comments."
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
