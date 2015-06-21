class PupsController < ApplicationController
  before_action :set_pup, only: [:show, :edit, :update, :destroy]
  before_action :set_user

  # GET /pups
  def index
    @pups = current_user.pups
  end

  def show; end

  # GET /pups/new
  def new
    @pup = Pup.new
  end

  # GET /pups/1/edit
  def edit; end

  # POST /pups
  def create
    @pup = Pup.new(pup_params)
    respond_to do |format|
      if @pup.save
        format.html { redirect_to user_pups_path, notice: 'Pup created' }
        format.json { render :show, status: :created, location: @pup }
      else
        format.html { render :new } # by default request returns HTML
        format.json { render json: @pup.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pups/1
  # PATCH/PUT /pups/1.json
  def update
    respond_to do |format|
      if @pup.update(pup_params)
        format.html { redirect_to user_pups_path, notice: 'Pup updated' }
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

  def set_user
    @user = current_user
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def pup_params
    params[:pup]
  end
end
