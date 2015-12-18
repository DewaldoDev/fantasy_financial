class GroupsController < ApplicationController
  before_action :find_group, only: [:show, :edit, :update, :destroy]

  def index
    if params[:name]
      @groups = Group.where("LOWER(name) LIKE LOWER(?)", "%#{params[:name]}%")
    else
      @groups = Group.all
    end
  end

  def show
  end

  def new
    @group = Group.new
  end

  def create
    @participation = current_user.participations.create
    @group = Group.new(group_params)
    @group.participations << @participation

    if @group.save
      flash[:notice] = "Your group has been created"
      redirect_to group_path(@group)
    else
      flash[:warning] = "Could not create group"
      render 'new'
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
