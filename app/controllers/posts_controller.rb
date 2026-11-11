class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:edit, :update, :destroy]
  before_action :authorize_owner!, only: [:edit, :update, :destroy]

  def index
    @feed = params[:feed] == "mine" ? "mine" : "all"
    @posts = if @feed == "mine"
               current_user.posts
             else
               Post.visible_to(current_user)
             end
    @posts = @posts.includes(:user).order(created_at: :desc)
  end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to posts_path, notice: "Post successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to posts_path, notice: "Post successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy!
    redirect_to posts_path, notice: "Post successfully deleted.", status: :see_other
  end

  private

  def post_params
    params.require(:post).permit(:name, :image, :content, :tags)
  end

  def set_post
    @post = current_user.posts.find(params[:id])
  end

  def authorize_owner!
    authorize @post
  end
end
