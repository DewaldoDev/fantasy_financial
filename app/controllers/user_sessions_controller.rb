class UserSessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]


  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password])
      flash[:notice] = "Thanks for Logging in"
      redirect_to user_url(@user)
    else
      flash[:warning] = 'Login failed'
      render action: 'new'
    end
  end

  def destroy
    logout
    flash[:warning] = 'Logged out!'
    redirect_to :root
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
