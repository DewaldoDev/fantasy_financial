class GroupsController < ApplicationController
  before_action :find_group, only: [:show, :edit, :update, :create, :destroy]

  def index
    @groups = Group.all
  end

  def show
  end

  def new
    @group = Group.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def find_owned_stock
    @group = Group.find(params[:id])
  end

  def group_params

  end
end
