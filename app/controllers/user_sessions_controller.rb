class UserSessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]


  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password])
      flash[:notice] = "Thanks for Loging in"
      redirect_to user_url(@user)
    else
      flash[:warning] = 'Login failed'
      render action: 'new'
    end
  end

  def destroy
    logout
    flash[:notice] = 'Logged out!'
  end

  private

  def user_params
    params.require(:user).permite(:email, :password, :password_confirmation)
  end
end
