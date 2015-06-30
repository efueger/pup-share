class AvailabilitiesController < ApplicationController
  before_action :set_availability, only: [:show, :edit, :update, :destroy]

  def index
    if params[:user_id].nil?
      @availabilities = Availability.all
    else
      @availabilities = Availability.where(user_id: params[:user_id])
    end
  end

  def show; end

  def new
    @availability = Availability.new
  end

  def edit; end

  def create
    @availability = current_user.availabilities.new(availability_params)

    if @availability.save
      redirect_to user_availabilities_path(current_user), notice: 'Availability created'
    else
      render :new
    end
  end

  def update
    if @availability.update(availability_params)
      redirect_to user_availabilities_path(current_user), notice: 'Availability updated'
    else
      render :edit
    end
  end

  def destroy
    @availability.destroy
    redirect_to user_availabilities_path(current_user), notice: 'Availability destroyed'
  end

  private
  
  def set_availability
    @availability = Availability.find(params[:id])
  end

  def availability_params
    params.require(:availability).permit!
  end
end
