class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: [:edit, :update, :destroy]

  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to groups_path, notice: "Group Successfully Created"
    else
      flash[:alert] = @group.errors.full_messages.join(', ')
      render :new
    end
  end

  def edit; end

  def update
    if @group.update(post_params)
      redirect_to groups_path
    end
  end

  def destroy
    if @group.destroy
      redirect_to groups_path, notice: "Group successfully deleted"
    end
  end

  private

  def group_params
    params.require(:group).permit(:banner, :description, :name)
  end

  def set_group
    @group = Group.find(params[:id] || params[:post_id])
  end
end
