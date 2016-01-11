class GroupsController < ApplicationController
  before_action :find_group, only: [:show, :edit, :update, :destroy, :join]

  def index
    if params[:name]
      @groups = Group.where("LOWER(name) LIKE LOWER(?)", "%#{params[:name]}%").paginate(:page => params[:page])
    else
      @groups = Group.paginate(:page => params[:page])
    end
  end

  def show
    @logs = @group.logs
    @group.portfolios.each do |portfolio|
      portfolio.calculate_value
    end
    # @group.users.each do |user|
    #   @logs << user.logs
    # end
  end

  def new
    @group = Group.new
  end

  def create
    @participation = current_user.participations.new
    @group = Group.new(group_params)
    @group.participations << @participation
    @participation.save

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

  def join
    @user = current_user

    unless @group.is_full?
      @user.groups << @group
      redirect_to group_url(@group)
    else
      flash[:warning] = "Sorry, group has a maximum of #{@group.max_size} users."
      redirect_to :back
    end
  end

  private
  def find_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :start_date, :end_date, :starting_total, :max_size)
  end
end
