class Admin::CarsController < ApplicationController
  before_action :require_login
  before_action :require_admin
  def cars_for_user
    @cars = User.find(params[:user_id]).cars
  end

  def approve
    @car = Car.find(params[:id])
    @car.update(status: :approved)
    redirect_to cars_for_user, notice: "Car approved"
  end

  def reject
    @car = Car.find(params[:id])
    @car.update(status: :rejected)
    redirect_to cars_for_user, notice: "Car rejected"
  end
end
