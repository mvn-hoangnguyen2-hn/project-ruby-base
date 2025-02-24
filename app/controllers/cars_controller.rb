class CarsController < ApplicationController
  before_action :require_login

  def index
    @cars = current_user.cars
  end

  def edit
    @car = current_user.cars.find(params[:id])
  end

  def update
    @car = current_user.cars.find(params[:id])
    @car.status = :pending
    if @car.update(car_params)
      redirect_to cars_path, notice: "Car updated, awaiting admin approval"
    else
      render :edit
    end
  end

  private

  def car_params
    params.require(:car).permit(:brand, :model, :color, :license_plate)
  end
end
