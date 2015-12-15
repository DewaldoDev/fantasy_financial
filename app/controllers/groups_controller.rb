class GroupsController < ApplicationController
  before_action :find_group, only: [:show, :edit, :update, :destroy]

  def index
    @groups = Group.all
  end

  def show
  end

  def new
    @group = Group.new
  end

  def create
    #current_user method needs to be implemented!
    @participation = current_user.participations.create
    @group = @participation.group.new(group_params)

    if @group.save

    else

    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def find_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :start_date, :end_date, :starting_total, :max_size)
  end
end
