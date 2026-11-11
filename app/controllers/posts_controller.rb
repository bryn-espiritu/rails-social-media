class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:edit, :update, :destroy]
  before_action :authorize_owner!, only: [:edit, :update, :destroy]

  PER_PAGE = 10

  def index
    @feed = params[:feed] == "mine" ? "mine" : "all"
    @query = params[:q].to_s.strip.first(100)
    scope = @feed == "mine" ? current_user.posts : Post.visible_to(current_user)
    scope = scope.search_text(@query) if @query.present?

    @page = [params[:page].to_i, 1].max
    @total_pages = [(scope.count.to_f / PER_PAGE).ceil, 1].max
    @page = [@page, @total_pages].min
    @posts = scope.includes(:user, :likes).order(created_at: :desc, id: :desc)
                  .limit(PER_PAGE).offset((@page - 1) * PER_PAGE)
    @liked_post_ids = current_user.likes.where(post_id: @posts.map(&:id)).pluck(:post_id)
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
