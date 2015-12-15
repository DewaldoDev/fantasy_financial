class UserSessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if @user = login(params[params[:email], params[:password])
      flash[:notice] = "Thanks for Loging in"
      redirect_to user_url(@user)
    end
  end

  def destroy
    logout
    flash['']
  end
end
