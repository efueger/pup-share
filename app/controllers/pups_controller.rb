class PupsController < ApplicationController
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
#     binding.pry
    @pup = current_user.pups.new(pup_params)

    if @pup.save
      redirect_to user_pups_path, notice: 'Pup created'
    else
      render :new 
    end
  end

  def update
    respond_to do |format|
      if @pup.update(pup_params)
        format.html { redirect_to user_pups_path, notice: 'Pupdated' }
        format.json { render :show, status: :ok, location: @pup }
      else
        format.html { render :edit }
        format.json { render json: @pup.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pups/1
  # DELETE /pups/1.json
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
