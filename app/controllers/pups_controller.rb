class PupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_pup, only: [:show, :edit, :update, :destroy]

  def index
    @pups = current_user.pups
  end

  def show; end

  def new
    @pup = Pup.new
  end

  def edit; end

  def create
    @pup = current_user.pups.new(pup_params)

    if @pup.save
      redirect_to user_pups_path, notice: 'Pup created'
    else
      render :new 
    end
  end

  def update
    if @pup.update(pup_params)
      redirect_to user_pups_path, notice: 'Pupdated'
    else
      render :edit
    end
  end

  def destroy
    @pup.destroy
    respond_to do |format|
      format.html { redirect_to user_pups_path, notice: 'Pup destroyed' }
      format.json { head :no_content }
    end
  end

  private

  def set_pup
    @pup = Pup.find(params[:id])
  end

  def pup_params
    params.require(:pup).permit!
  end

end
