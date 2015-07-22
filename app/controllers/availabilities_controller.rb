class AvailabilitiesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_availability, only: [:show, :edit, :update, :destroy]

  def index
      @availabilities = Availability.all
  end

  def show; end

  def new
    @availability = Availability.new
  end

  def edit; end

  def create
    @availability = current_user.availabilities.new(availability_params)

    if @availability.save
      redirect_to user_path(current_user), notice: 'Availability created'
    else
      render :new
    end
  end

  def update
    if @availability.update(availability_params)
      redirect_to user_path(current_user), notice: 'Availability updated'
    else
      render :edit
    end
  end

  def destroy
    @availability.destroy
    redirect_to user_path(current_user), notice: 'Availability destroyed'
  end

  private

  def set_availability
    @availability = Availability.find(params[:id])
  end

  def availability_params
    params.require(:availability).permit!
  end
end
