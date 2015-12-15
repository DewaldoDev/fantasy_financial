class UsersController < ApplicationController
  skip_before_action :require_login, only: [:index, :new, :create]
  before_action :find_user, only: [:show, :edit, :update, :destroy]

  def index
  end

  def show
  end

  def new
    @user = User.new(user_params)
  end

  def create
    @user = User.new(user_params)
    if @user.save
    redirect_to(:users, notice: 'User was successfully created')
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to user_path(@user)
    end
  end

  def destroy
    @user.destroy
    redirect_to :root
  end
  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :user_name)
  end

  def find_user
    @user = User.find(params[:id])
  end

end
