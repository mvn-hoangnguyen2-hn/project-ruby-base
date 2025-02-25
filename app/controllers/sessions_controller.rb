class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email])

    if @user&.authenticate(params[:password])
      cookies.signed[:user_id] = { value: @user.id, expires: 1.hour.from_now }
      cookies[:username] = { value: @user.name, expires: 1.hour.from_now }
      redirect_to home_path, notice: "Logged in successfully as admin"
    else
      flash.now[:alert] = "Invalid email or password"
      render :new, status: 400
    end
  end

  def logout
    cookies.delete(:user_id)
    redirect_to root_path, notice: "Logged out successfully"
  end
end
