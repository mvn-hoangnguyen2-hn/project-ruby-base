class Admin::UsersController < ApplicationController
  before_action :require_login, :require_admin
  before_action :set_user, only: [ :edit, :update, :destroy ]

  def index
    @users = User.includes(:cars).all
  end

  def new
    @user = User.new
    2.times { @user.cars.build }
  end

  def create
    @user = User.new(user_params)
    @user.cars.each { |car| car.status = :approved }
    if @user.save
      redirect_to admin_users_path, notice: "User created success"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "User updated success"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: "The user has been successfully deleted"
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :age, :phone, cars_attributes: [:make, :model, :color, :license_plate])
  end
end
