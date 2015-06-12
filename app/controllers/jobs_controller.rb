class JobsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :walk_request, :approve_walk_request, :deny_walk_request]
  before_action :set_job, only: [:show, :edit, :update, :destroy, :walk_request, :approve_walk_request, :deny_walk_request]

  def index
    @jobs = Job.all
  end

  def show
  end

  def new
    @job = Job.new
  end

  def edit
  end

  def create
    @job = current_user.jobs.new(job_params)

    respond_to do |format|
      if @job.save
        format.html { redirect_to root_path, notice: 'Job was successfully created.' }
        format.json { render :show, status: :created, location: @job }
      else
        format.html { render :new }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  def walk_request
    @job.walk_request(current_user)
    redirect_to root_path, notice: 'Request email sent to pup\'s owner'
  end
  
  def cancel_walk_request
    # allow walker to cancel walk request in two places: 
    # 1) in the confirmation email they receive after making a request (yet to be built)
    # 2) in the confirmation email they receive after a pup owner approves the walk request
  end

  def approve_walk_request
    @job.approve_walk_request(current_user)
    redirect_to root_path, notice: 'Thanks for approving the walk request. We sent a confirmation email to the walker!'      
  end

  def deny_walk_request
    @job.deny_walk_request(current_user)
    redirect_to root_path, alert: 'Sorry to hear you\'re denying the walk request. We sent a confirmation email to the requester'
  end

  def update
    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to root_path, notice: 'Job was successfully updated.' }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @job.destroy
    respond_to do |format|
      format.html { redirect_to jobs_url, notice: 'Job was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_job
    @job = Job.find(params[:id])
  end

  def job_params
    params.require(:job).permit!
  end
end