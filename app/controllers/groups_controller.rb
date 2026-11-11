class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: [:edit, :update, :destroy]
  before_action :authorize_owner!, only: [:edit, :update, :destroy]

  def index
    @groups = Group.order(created_at: :desc)
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      redirect_to groups_path, notice: "Group successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @group.update(group_params)
      redirect_to groups_path, notice: "Group updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @group.destroy!
    redirect_to groups_path, notice: "Group deleted.", status: :see_other
  end

  private

  def group_params
    params.require(:group).permit(:banner, :description, :name)
  end

  def set_group
    @group = Group.find(params[:id])
  end

  def authorize_owner!
    return if @group.owner_id == current_user.id

    redirect_to groups_path, alert: "Only the group owner can modify this group."
  end
end
