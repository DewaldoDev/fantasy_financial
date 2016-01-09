class UsersController < ApplicationController
  skip_before_action :require_login, only: [:home, :index, :new, :create]
  before_action :find_user, only: [:show, :edit, :update, :destroy]

  def home
    @gainers = BaseStock.order("change DESC").limit(10)
    @losers = BaseStock.order("change ASC").limit(10)
  end

  def index
  end

  def show
    @user.portfolios.each do |portfolio|
      portfolio.calculate_value
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to(:root, notice: 'User was successfully created')
    else
      flash[:warning] = "Profile could not be created"
      render 'new'
    end
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
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :username)
  end

  def find_user
    @user = User.find(params[:id])
  end

end
