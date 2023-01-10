class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:edit, :update, :destroy]
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def index
    @posts = Post.includes(:user).public_tag
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to posts_path, notice: "post is Successfully Submitted"
    else
      flash[:alert] = @post.errors.full_messages.join(', ')
      render :new
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to posts_path
    end
  end

  def destroy
    if @post.destroy
      redirect_to post_paths, notice: "post successfully deleted"
    end
  end

  private

  def post_params
    params.require(:post).permit(:name, :image, :content, :tags)
  end

  def set_post
    @post = Post.find(params[:id] || params[:post_id])
  end

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore
    flash[:alert] = t "#{policy_name}.#{exception.query}", scope: 'pundit', default: :default,
                      username: exception.policy.record&.user&.email
    redirect_to(request.referrer || root_path)
  end

end

