class Admin::UsersController < ApplicationController
  before_action :require_login, :require_admin
  before_action :set_user, only: [ :edit, :update, :destroy ]

  def index
    @users = User.includes(:cars).all
  end

  def new
    @user = User.new
    @car1 = @user.cars.build
    @car2 = @user.cars.build
  end

  def create
    Rails.logger.debug(params.inspect)
    @user = User.new(user_params)
    @car1 = @user.cars.build(car_params1) if car_params1.present?
    @car1.status = :approved
    @car2 = @user.cars.build(car_params2) if car_params2.present?
    @car2.status = :approved
    if @user.save
      redirect_to admin_users_path, notice: "User created success"
    else
      Rails.logger.error("User save failed: #{@user.errors.full_messages.join(', ')}")
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
    if @user.role == :admin
      redirect_to admin_users_path, alert: "Users with the admin role cannot be deleted"
    else
      @user.destroy
      redirect_to admin_users_path, notice: "The user has been successfully deleted"
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def car_params1
    params.require(:car1).permit(:make, :model, :color, :license_plate)
  end

  def car_params2
    params.require(:car2).permit(:make, :model, :color, :license_plate)
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :age, :phone)
  end
end
